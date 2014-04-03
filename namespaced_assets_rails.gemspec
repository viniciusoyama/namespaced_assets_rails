$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "namespaced_assets_rails/version"

Gem::Specification.new do |spec|
  spec.name          = "namespaced_assets_rails"
  spec.version       = NamespacedAssetsRails::VERSION.freeze
  spec.authors       = ["Vinícius Oyama"]
  spec.email         = ["vinicius.oyama@gmail.com"]
  spec.description   = %q{Organize your javascript and css's across namespaces matching your controllers, actions and renderized views. Get automatic executing functions in Javascript for the current controller,action and view.}
  spec.summary       = %q{Organize your javascript and css's across namespaces matching your controllers, actions and renderized views. Get automatic executing functions in Javascript for the current controller,action and view.}
  spec.authors       = ['Vinícius Oyama']
  spec.email         = "vinicius.oyama@codus.com.br"
  spec.homepage      = "https://github.com/codus/codus"
  spec.license       = "MIT"

  spec.test_files = Dir["spec/**/*"]
  spec.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 4.1.0.rc2"
end
