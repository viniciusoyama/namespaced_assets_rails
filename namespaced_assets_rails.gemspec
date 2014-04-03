# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'namespaced_assets_rails/version'

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

  s.test_files = Dir["spec/**/*"]
  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.1.0"
end
