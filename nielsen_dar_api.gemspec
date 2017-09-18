# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nielsen_dar_api/version'

Gem::Specification.new do |spec|
  spec.name          = "nielsen_dar_api"
  spec.version       = NielsenDarApi::VERSION
  spec.authors       = ["Mauro Berlanda"]
  spec.email         = ["mauro.berlanda@gmail.com"]

  spec.summary       = "Ruby gem to call Nielsen DAR API"
  spec.homepage      = "https://github.com/mberlanda/nielsen_dar_api"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency 'rest-client', '~> 2.0'
end
