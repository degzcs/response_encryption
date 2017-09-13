# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "response_encryption/version"

Gem::Specification.new do |spec|
  spec.name          = "response_encryption"
  spec.version       = ResponseEncryption::VERSION
  spec.authors       = ["Diego Gomez"]
  spec.email         = ["diego.f.gomez.pardo@gmail.com"]

  spec.summary       = %q{Gem to encrypt the API response}
  spec.description   = %q{Gem to encrypt the API response.}
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/degzcs/response_encryption"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec-rails', "~> 3.0"
  spec.add_development_dependency "spirit_hands", "~> 2.1"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency 'active_model_serializers', '~> 0.10'
  spec.add_development_dependency 'jsonapi-resources', '~> 0.9'
  spec.add_dependency "rails", "~> 5.1"

end
