#
# ordnung/database/elasticsearch
#
# Elasticsearch database backend for Ordnung

require "elasticsearch"

module Ordnung
  TYPE = "ordnung"
  class Database
    private
      def _mappings
        {
          TYPE => {
            ctime:         { type: 'date'                          },
            locations:     { type: 'string', index: 'not_analyzed' },
            mimetype:      { type: 'string', index: 'not_analyzed' },
            mtime:         { type: 'date'                          },
            name:          { type: 'string', index: 'not_analyzed' },
            size:          { type: 'long'                          },
            tags:          { type: 'string', index: 'not_analyzed' },
          }
        }
      end
      def provide_mappings_to_elasticsearch mappings
        mappings.each do |type, mapping|
          # insert ':properties' level
          # see https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html
          # add 'timestamp' and 'hostname'
          properties = mapping
#          puts "#{self.class} mappings #{type} => #{properties.inspect}"
          
          # create or update mapping
          begin
            # try create, might fail with 'index_already_exists_exception'
            @client.indices.create index: @index,
              body: {
                mappings: {
                  type => { properties: properties }
                }
              }
            rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
              if e.message =~ /index_already_exists_exception/
                # update mapping
                @client.indices.put_mapping index: @index, type: type,
                body: {
                  type => { properties: properties }
                }
              else
                Logger.error "Can't create index #{@index.inspect}: #{e}"
                raise
              end
          end
        end
      end
    public
    def initialize
      @client = Elasticsearch::Client.new # log: true
      @index = Config.elasticsearch['index']
#      puts "Elasticsearch index #{@index.inspect}"
      provide_mappings_to_elasticsearch _mappings
    end
    def client
      @client
    end
    #
    # CRUD basics
    #
    def create id, body
      obj = @client.create index: @index, type: TYPE, id: id, body: body
#      puts "Create: #{obj.inspect}"
      obj['_id']
    end
    def update id, body
      begin
        obj = @client.index index: @index, type: TYPE, id: id, body: body
#        puts "Update: #{obj.inspect}"
        obj['_id']
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
        Logger.error "Elasticsearch update failed for id #{id} body #{body.inspect}"
        Logger.error "  with #{e}"
        nil
      end
    end
    def index
      search Hash.new
    end
    def search hash
      puts "search #{hash.inspect}"
      query = ""
      hash.each do |k,v|
        query << " and " unless query.empty?
        query << "#{k}:#{v}"
      end
      query = { match_all: {} } if query.empty?
      puts "Query #{query.inspect}"
      begin
        obj = @client.search index: @index, q: query
        puts "@client.search #{obj.inspect}"
        hits = obj["hits"]
        total = hits["total"] rescue 0
        if total > 0
          res = hits["hits"].map do |hit|
            hit["_id"]
          end
        else
          res = []
        end
#        puts "Search: #{res.inspect}"
        res
      rescue Exception => e
        Logger.error "Elasticsearch.search(#{hash.inspect}) failed: #{e}"
        raise
      end
    end
    def read id
      begin
        obj = @client.get index: @index, type: TYPE, id: id
#        puts "Read: #{obj.inspect}"
        obj['_source']
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        nil
      end
    end
    def delete id
      obj = @client.delete index: @index, type: TYPE, id: id
      obj['_id']
    end
  end
end
