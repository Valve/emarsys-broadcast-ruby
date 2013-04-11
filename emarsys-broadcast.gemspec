# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emarsys/broadcast/version'

Gem::Specification.new do |spec|
  spec.name          = "emarsys-broadcast"
  spec.version       = Emarsys::Broadcast::VERSION
  spec.authors       = ["Valentin Vasilyev"]
  spec.email         = ["iamvalentin@gmail.com"]
  spec.description   = %q{Emarsys broadcast API for Ruby}
  spec.summary       = %q{Emarsys broadcast API for Ruby}
  spec.homepage      = "https://github.com/Valve/emarsys-broadcast-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "net-sftp"
  spec.add_dependency "nokogiri", "1.5.6"
  spec.add_dependency "activemodel", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.11"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "webmock"
end
