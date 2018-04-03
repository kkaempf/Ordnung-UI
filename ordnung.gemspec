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
  s.rubyforge_project       = "Ordnung"
  s.bindir                  = "bin"
  s.require_paths           = ["lib"]
  s.homepage                = "http://github.com/kkaempf/Ordnung"
  s.license                 = "MIT"
  s.add_runtime_dependency("trollop", ["2.1.2"])
  s.add_runtime_dependency("sinatra", ["2.0.0"])
  s.add_runtime_dependency("sprockets", ["3.7.1"])
  s.add_runtime_dependency("json", ["2.1.0"])
  s.add_runtime_dependency("haml", ["5.0.4"])
  s.add_runtime_dependency("elasticsearch", ["6.0.2"])
  s.add_development_dependency("rack", ["2.0.4"])
  s.add_development_dependency("capybara", ["2.18.0"])
  s.add_development_dependency("selenium", ["0.2.11"])
  s.add_development_dependency("selenium-webdriver", ["3.11.0"])
  s.add_development_dependency("chromedriver-helper", ["1.2.0"])
end
