# test files api
require_relative "test_helper"

describe 'File' do
  include Rack::Test::Methods

  before(:all) do
    Ordnung::File.strip = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..'))
    @f = Ordnung::File.new __FILE__
  end

  describe "file common directory path strip" do
    it "has a strip component ending with a slash" do
      Ordnung::File.strip = "/a/b/c"
      expect(Ordnung::File.strip).to be == '/a/b/c/'
      Ordnung::File.strip = "/a/"
      expect(Ordnung::File.strip).to be == '/a/'
    end
  end
  describe "file constructor" do
    it "keeps name, extension, and directory" do
      expect(@f.name).to be == 'ordnung_file_test.rb'
      expect(@f.extension).to be == 'rb'
      expect(@f.directory).to be == 'Ordnung/test/backend'
    end
  end
  describe "file database" do
    it "can be stored and retrieved" do
      g = Ordnung::File.repo[@f.id]
      expect(g.name).to be == @f.name
      expect(g.extension).to be == @f.extension
      expect(g.directory).to be == @f.directory
    end
  end
end
