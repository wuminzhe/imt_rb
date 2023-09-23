# frozen_string_literal: true

require_relative "lib/imt_rb/version"

Gem::Specification.new do |spec|
  spec.name = "imt_rb"
  spec.version = ImtRb::VERSION
  spec.authors = ["Aki Wu"]
  spec.email = ["wuminzhe@gmail.com"]

  spec.summary = "Incremental Merkle Tree in Ruby"
  spec.description = "Incremental Merkle Tree in Ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "keccak256"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
