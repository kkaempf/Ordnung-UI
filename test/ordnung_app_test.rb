
describe 'Ordnung App' do
  include Rack::Test::Methods

  def app
    App.new
  end

  it "displays home page" do 
    get '/'

    expect(last_response.body).to include("Ordnung")
  end

  it "displays help page" do 
    get '/help'

    expect(last_response.body).to include("Help")
  end

end
