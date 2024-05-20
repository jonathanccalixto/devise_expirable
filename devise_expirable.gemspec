# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise/expirable/version'

Gem::Specification.new do |spec|
  spec.name          = "devise_expirable"
  spec.version       = DeviseExpirable::VERSION
  spec.authors       = ["Jonathan C. Calixto"]
  spec.email         = ["jonathanccalixto@gmail.com"]
  spec.summary       = %q{Expires user password after a period}
  spec.description   = %q{This is a simple, however wonderful devise extension to expire user password.}
  spec.homepage      = "https://github.com/jonathanccalixto/devise_expirable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "devise", ">= 2.0"
end
