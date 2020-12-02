# test database api
require_relative "test_helper"

describe 'Database' do
  include Rack::Test::Methods

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

  describe "crud interface" do
    it "finds data" do
      expect(@db.index.count).to be == 3
    end
  end
end
