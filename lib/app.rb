Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require "sinatra/base"
require "sprockets"
require "haml"
require "json"
require "time"
require "ordnung"

require_relative "ordnung-ui"

class App < Sinatra::Base
  set :environment, Sprockets::Environment.new
  environment.append_path "assets/bootstrap"
  environment.append_path "assets/vue"

  ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), ".."))

  self.set :root, File.join(ROOT_PATH, "lib")
  set :public_folder, File.join(ROOT_PATH, "public")
  set :views, File.join(ROOT_PATH, "views")
  set :bind, "0.0.0.0"
  set :port, OrdnungUI::Config["port"] || 4567

  theme = OrdnungUI::Config["theme"] || "default"
end

class App < Sinatra::Base
  def initialize
    super
    @title = OrdnungUI::Config["title"] || "Ordnung"
    @theme_type = get_theme_type
    @colors = OrdnungUI.get_colors
    Ordnung::Logger.info "Starting server app #{ARGV.inspect}"
    @ui = OrdnungUI::UI.new
  end

  helpers do
    ### generic helpers

    def get_theme_type
      theme = OrdnungUI::Config["theme"] || "default"
      if ["cyborg", "darkly", "slate", "superhero"].include? theme
        "dark"
      else
        "light"
      end
    end

  end
end

class App < Sinatra::Base
  #
  # MAIN Routes
  #

  get "/" do
    Ordnung.logger.info "get /"
    haml :ordnung
  end

  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end

  get "/api/help" do
    routes = []
    App.each_route do |route|
      routes << {:route => route.path} if route.path.is_a? String
    end
    routes.uniq.to_json
  end
  get "/api/file/count.json" do
    return { count: Ordnung::File.count }.to_json
  end
end
