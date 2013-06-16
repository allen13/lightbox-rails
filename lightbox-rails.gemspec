require File.expand_path("../lib/lightbox-rails/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "lightbox-rails"
  gem.version = LightboxRails::VERSION

  gem.authors = "Vinny Diehl"
  gem.email = "gbchaosmaster926@gmail.com"
  gem.homepage = "https://github.com/gbchaosmaster/lightbox-rails"

  gem.summary = "Rails plugin for Lightbox 2"
  gem.description = "Adds helpers for easy creation of Lightbox 2 groups."

  gem.files = Dir["{lib,vendor}/**/*"] + %w[
    MIT-LICENSE Rakefile README.md lightbox-rails.gemspec
  ]

  gem.add_dependency "rails", "> 3.2.8"
end
