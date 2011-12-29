$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:

require "fb_graph_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "fb_graph_rails"
  s.version     = FbGraphRails::VERSION
  s.authors     = ["Fabian Otto", "Paul Spieker"]
  s.email       = ["fabian.otto@familienservice.de", "paul.spieker@familienservice.de"]
  s.homepage    = "https://github.com/zickzackv/fb_graph_rails"
  s.summary     = "A (really) simple gem around fb_graph for canvas authentication in Facebook"
  s.description = ""

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  s.add_dependency "fb_graph", "~> 2.2.4"
end
