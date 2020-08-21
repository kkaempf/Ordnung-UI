# test database api
require_relative "test_helper"

describe 'Database' do
  include Rack::Test::Methods

  def delete_index
    begin
      db = Ordnung::Database.new
      index = Ordnung::Config.elasticsearch['index']
#      db.client.indices.delete index: index
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
    end
  end

  before(:all) do 
    unless Ordnung::Config.database == 'elasticsearch'
      fail "Only Elasticsearch supported, sorry"
    end
    begin
      @db = Ordnung::Database.new
    rescue Faraday::ConnectionFailed
      fail "Elasticsearch not running"
    end
  end
  after(:all) do
    delete_index
  end

  describe "crud interface" do
    it "creates data" do
      id1 = @db.create '1', { name: 'one' }
      expect(id1).to be == '1'
      id2 = @db.create '2', { name: 'two' }
      expect(id2).to be == '2'
      id3 = @db.create '3', { name: 'three' }
      expect(id3).to be == '3'
    end
    it "reads data" do
      data = @db.read('3')
      expect(data['name']).to be == 'three'
      data = @db.read('2')
      expect(data['name']).to be == 'two'
      data = @db.read('1')
      expect(data['name']).to be == 'one'
    end
    it "finds data" do
      expect(@db.index.count).to be == 3
    end
  end
end
