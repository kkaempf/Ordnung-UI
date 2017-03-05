
describe 'Ordnung import' do
  include Rack::Test::Methods

  before(:all) do
    @ordnung = Ordnung::Ordnung.new
    @database = Ordnung::Database.new
  end

  it "imports data directory" do 
    @ordnung.import File.join(TOPLEVEL, 'data')
  end

end
