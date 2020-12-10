# test files api
require_relative "test_helper"

describe 'Extension' do
  include Rack::Test::Methods

  describe "extension management" do
    it "has name and id" do
      ext = Ordnung::Extension.new("rb")
      expect(ext.name).to be == 'rb'
      expect(ext.id.class).to be == Integer
    end
    it "creates extensions" do
      ext = Ordnung::Extension.new("rb")
      expect(ext.name).to be == 'rb'
    end
    it "strips leading dots" do
      ext = Ordnung::Extension.new(".rb")
      expect(ext.name).to be == 'rb'
    end
    it "is case insensitive" do
      down = Ordnung::Extension.new("jpg")
      up = Ordnung::Extension.new("JPG")
      expect(up.id).to be == down.id
    end
  end
end
