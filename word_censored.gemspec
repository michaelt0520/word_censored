lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "word_censored/version"

Gem::Specification.new do |spec|
  spec.name          = "word_censored"
  spec.version       = WordCensored::VERSION
  spec.authors       = ["Michael Tran"]
  spec.email         = ["mictran205@gmail.com"]

  spec.summary       = "Filter badword from blacklist"
  spec.description   = "Censored all badword from available blacklist"
  spec.homepage      = "https://github.com/michaelt0520/word_censored"
  spec.license       = "MIT"

  spec.files         = [".gitignore", "CODE_OF_CONDUCT.md", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "bin/console", "bin/setup", "lib/word_censored.rb", "lib/files/blacklist.json", "lib/word_censored/version.rb", "word_censored.gemspec"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
end
