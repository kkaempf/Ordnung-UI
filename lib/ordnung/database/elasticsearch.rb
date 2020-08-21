#
# ordnung/database/elasticsearch
#
# Elasticsearch database backend for Ordnung

require "elasticsearch"
require "json"

module Ordnung
  TYPE = "ordnung"
  class Database
    public
    def initialize
      @client = Elasticsearch::Client.new logger: ::Ordnung.logger #, trace: true
      @index = Config.elasticsearch['index']
      @mapping = Config.elasticsearch['mapping']
      Logger.info "mapping #{@mapping.inspect}"
      begin
        index_settings = { number_of_shards: 1, number_of_replicas: 0 }
        settings = { settings: { index: index_settings } }
        res = @client.indices.create index: @index, body: settings
        Logger.info "Create index #{@index.inspect}: #{res.inspect}"
        res = @client.indices.put_mapping index: @index, body: @mapping.to_json
        Logger.info "Put mapping #{@mapping.inspect}: #{res.inspect}"
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest
        # index already exists
      end
    end
    def client
      @client
    end
    #
    # CRUD basics
    #
    def create id, body
      obj = @client.create index: @index, id: id, body: body
      Logger.info "Create #{@index}/#{id.inspect}(#{body.inspect}): #{obj.inspect}"
      obj['_id']
    end
    def update id, body
      begin
        obj = @client.index index: @index, id: id, body: body
        Logger.info "Update #{@index}/#{id.inspect}(#{body.inspect}): #{obj.inspect}"
        obj['_id']
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
        Logger.error "Elasticsearch update failed for id #{id} body #{body.inspect}"
        Logger.error "  with #{e}"
        nil
      end
    end
    # alias for 'search all'
    def index
      search
    end
    def search q=nil
      Logger.info "search #{q.inspect}"
      query = nil
      case q
      when nil
        # skip
      when String
        query = q
      when Hash
        query = ""
        q.each do |k,v|
          query << " and " unless query.empty?
          query << "#{k}:#{v}"
        end
      else
        Logger.error "Can't handle search type #{q.class}"
        return
      end
      begin
#        obj = @client.perform_request 'POST', "#{@index}/_search", {}, query
        if query
          obj = @client.search index: @index, q: query
        else
          obj = @client.search index: @index
        end
        Logger.info "search #{@index.inspect}: query #{query.inspect} result: #{obj.inspect}"
        hits = obj["hits"]
        total = hits["total"]["value"] rescue 0
        if total > 0
          res = hits["hits"].map do |hit|
            hit["_id"]
          end
        else
          res = []
        end
        Logger.info "Search count: #{res.inspect}"
        res
      rescue Exception => e
        Logger.error "Elasticsearch.search(#{hash.inspect}) failed: #{e}"
        raise
      end
    end
    def read id
      begin
        obj = @client.get index: @index, id: id
        Logger.info "Read #{id} result: #{obj.inspect}"
        obj['_source']
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        nil
      end
    end
    def delete id
      obj = @client.delete index: @index, id: id
      Logger.info "Delete #{id} result: #{obj.inspect}"
      obj['_id']
    end
  end
end
