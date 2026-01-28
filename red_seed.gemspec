# frozen_string_literal: true

require_relative "lib/red_seed/version"

Gem::Specification.new do |spec|
  spec.name          = "red_seed"
  spec.version       = RedSeed::VERSION
  spec.authors       = ["shamss11"]
  spec.email         = ["vchfam@gmail.com"]

  spec.summary       = "A CLI tool for analyzing food security in Vancouver neighborhoods."
  spec.description   = "RedSeed uses Vancouver Open Data to calculate food security " \
                       "scores based on community gardens and free meal programs."
  spec.homepage      = "https://github.com/shamss11/RedSeed"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["urban"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.0"
  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "terminal-table", "~> 3.0"
end
