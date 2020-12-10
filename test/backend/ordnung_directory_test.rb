# test files api
require_relative "test_helper"

describe 'Directory' do
  include Rack::Test::Methods

  describe "directory management" do
    it "creates directories" do
      dirname = File.dirname(__FILE__)
      dir = Ordnung::Directory.new(dirname)
      expect(dir.name).to be == 'backend'
      expect(Ordnung::Directory[dir.parent].name).to be == 'test'
    end
  end
end
