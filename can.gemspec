lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "can"

Gem::Specification.new do |spec|
  spec.name          = "can"
  spec.version       = Can::VERSION
  spec.summary       = "Can stores encrypted goods using symmetric cryptography."
  # spec.description   = File.read("readme.md")
  spec.description   = "Can stores encrypted goods using symmetric cryptography (AES-256-CBC)"
  spec.homepage      = "https://github.com/ptdorf/can"
  spec.authors       = ["ptdorf"]
  spec.email         = ["ptdorf@gmail.com"]
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split $/
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename f }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "tablelize"
  spec.add_dependency "base62-rb"
  spec.add_development_dependency "rake"

  # spec.required_ruby_version = "~> 2.4"
end
