require_relative "test_helper"

describe 'Ordnung import' do
  include Rack::Test::Methods
if false
  before(:all) do
    @ordnung = Ordnung::Ordnung.new
    @db = Ordnung::Database.new
    @db.delete_table
    @datadir = File.expand_path(File.join(TOPLEVEL, 'data'))
  end
  after(:all) do
    @db.delete_table
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
end
