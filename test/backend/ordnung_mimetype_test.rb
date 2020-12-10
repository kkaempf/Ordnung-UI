# test files api
require_relative "test_helper"

describe 'MimeType' do
  include Rack::Test::Methods

  describe "mimetype management" do
    it "has name and id" do
      mt = Ordnung::MimeType.new("text/plain")
      expect(mt.name).to be == 'text/plain'
      expect(mt.id.class).to be == Integer
    end
    it "is case insensitive" do
      down = Ordnung::MimeType.new("text/plain")
      up = Ordnung::MimeType.new("text/plain".capitalize)
      expect(up.id).to be == down.id
    end
  end
end
