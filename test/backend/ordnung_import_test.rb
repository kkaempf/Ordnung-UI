require_relative "test_helper"

describe 'Ordnung import' do
  include Rack::Test::Methods

  def delete_index
    begin
#      @client.indices.delete index: @index
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
    end
  end

  before(:all) do
    @ordnung = Ordnung::Ordnung.new
    @db = Ordnung::Database.new
    @client = @db.client
    @index = Ordnung::Config.elasticsearch['index']
    @datadir = File.expand_path(File.join(TOPLEVEL, 'data'))
    delete_index
  end
  after(:all) do
    delete_index
  end

  it "imports data directory" do 
    @ordnung.import @datadir
  end

  it "imports all files" do
    Dir.open(@datadir).each do |name|
      next if name[0,1] == '.'
      @ordnung.import @datadir, name
      res = @db.search( name )
      expect(res.size).not_to eql(0)
#      expect(res["hits"]["_source"]["name"]).to eql(name)
    end
  end
end
