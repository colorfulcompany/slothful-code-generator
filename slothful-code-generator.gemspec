lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slothful_code/version"

Gem::Specification.new do |spec|
  spec.name          = "slothful-code-generator"
  spec.version       = SlothfulCode::VERSION
  spec.authors       = [""]
  spec.email         = [""]

  spec.summary       = %q{generate time-based unique id with loose precision}
  spec.description   = # %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/colorfulcompany/slothful-code-generator"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
#  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "hashids", "~> 1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-skip"
  spec.add_development_dependency "minitest-power_assert", "~> 0.3"
  spec.add_development_dependency "power_assert", "~> 2.0"
  spec.add_development_dependency "minitest-reporters", "~> 1"
  spec.add_development_dependency "steep"
end
