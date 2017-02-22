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
            tags:          { type: 'string', index: 'not_analyzed' },
            name:          { type: 'string', index: 'not_analyzed' },
            type:          { type: 'string', index: 'not_analyzed' },
            path:          { type: 'string', index: 'not_analyzed' }
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
      puts "Elasticsearch index #{@index.inspect}"
      provide_mappings_to_elasticsearch _mappings
    end
    def write body
      @client.index index: @index, type: TYPE, body: body
#     puts body.inspect
    end
  end
end
