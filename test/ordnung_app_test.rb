ENV['RACK_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))
load 'bin/app'
require 'rspec'
require 'rack/test'

describe 'Ordnung App' do
  include Rack::Test::Methods

  def app
    App.new
  end

  it "displays home page" do 
    get '/'

    expect(last_response.body).to include("Hello world!")
  end

  it "displays help page" do 
    get '/help'

    expect(last_response.body).to include("Help")
  end

end
