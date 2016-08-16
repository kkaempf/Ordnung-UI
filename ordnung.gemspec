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
  s.add_dependency("sinatra-base", ["1.4.7"])
  s.add_dependency("sinatra-assetpack", ["0.3.5"])
  s.add_dependency("sinatra-advanced-routes", ["0.5.3"])
  s.add_dependency("haml", ["4.0.7"])
  s.add_dependency("elasticsearch", ["2.0.0"])
end
