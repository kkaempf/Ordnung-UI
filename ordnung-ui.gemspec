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
  s.add_runtime_dependency("ordnung", "~> 0.1.2")
  s.add_runtime_dependency("webrick", "~> 1.9")
  s.add_runtime_dependency("haml", "~> 7.0")
  s.add_runtime_dependency("json", "~> 2.16")
  s.add_runtime_dependency("optimist", "~> 3.2")
  s.add_runtime_dependency("sinatra", "~> 4.2")
  s.add_runtime_dependency("sprockets", "~> 4.2")
  s.add_development_dependency("rspec", "~> 3.13")
  s.add_development_dependency("rack", "~> 3.2")
  s.add_development_dependency("rack-test", "~> 2.2")
  s.add_development_dependency("capybara", "~> 3.40")
  s.add_development_dependency("selenium-webdriver", "~> 4.38")
end
