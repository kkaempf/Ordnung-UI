require_relative 'lib/ordnung-ui'

Gem::Specification.new do |s|
  s.name                    = "OrdnungUI"
  s.version                 = OrdnungUI::VERSION
  s.date                    = Time.now.strftime("%Y-%m-%d")
  s.summary                 = "Keep all your data organized"
  s.description             = "Keep all your data organized"
  s.authors                 = ["Klaus Kämpf"]
  s.email                   = "kkaempf@suse.de"
  s.files                   = `git ls-files`.split("\n")
  s.executables             = ["ordnung"]
  s.bindir                  = "bin"
  s.require_paths           = ["lib"]
  s.homepage                = "http://github.com/kkaempf/Ordnung-UI"
  s.license                 = "MIT"
  s.add_runtime_dependency("webrick")
  s.add_runtime_dependency("haml")
  s.add_runtime_dependency("json", "~> 2.6")
  s.add_runtime_dependency("optimist")
  s.add_runtime_dependency("arango-driver", "~> 3.8")
  s.add_runtime_dependency("sinatra")
  s.add_runtime_dependency("sprockets")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rack", "~> 2.2")
  s.add_development_dependency("rack-test", "~> 1.1")
  s.add_development_dependency("capybara")
  s.add_development_dependency("selenium-webdriver", "~> 4.0")
  s.add_development_dependency("webdrivers", "~> 4.7")
end
