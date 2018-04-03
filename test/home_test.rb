class HomeTest < Test::Unit::TestCase
  include Capybara::DSL
      
  def setup
    Capybara.app = Sinatra::Application.new
  end
            
  def test_it_works
    visit '/'
    assert page.has_content?('Ordnung')
  end
end
