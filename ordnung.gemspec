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
  s.add_dependency("trollop", ["2.1.2"])
  s.add_dependency("sinatra", ["2.0.0"])
  s.add_dependency("sprockets", ["3.7.1"])
  s.add_dependency("json", ["2.1.0"])
  s.add_dependency("haml", ["5.0.4"])
  s.add_dependency("elasticsearch", ["6.0.2"])
end
