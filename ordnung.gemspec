require_relative 'lib/ordnung/version'

Gem::Specification.new do |s|
  s.name                    = "Ordnung"
  s.version                 = Ordnung::VERSION
  s.date                    = Time.now.strftime("%Y-%m-%d")
  s.summary                 = "Keep all your data organized"
  s.description             = "Keep all your data organized"
  s.authors                 = ["Klaus Kämpf"]
  s.email                   = "kkaempf@suse.de"
  s.files                   = `git ls-files`.split("\n")
  s.executables             = ["ordnung"]
  s.bindir                  = "bin"
  s.require_paths           = ["lib"]
  s.homepage                = "http://github.com/kkaempf/Ordnung"
  s.license                 = "MIT"
  s.add_runtime_dependency("haml")
  s.add_runtime_dependency("json")
  s.add_runtime_dependency("optimist")
  s.add_runtime_dependency("rom")
  s.add_runtime_dependency("rom-sql")
  s.add_runtime_dependency("sinatra")
  s.add_runtime_dependency("sprockets")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rack")
  s.add_development_dependency("capybara")
  s.add_development_dependency("selenium")
  s.add_development_dependency("selenium-webdriver")
  s.add_development_dependency("chromedriver-helper")
end
