# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vundabar/version"

Gem::Specification.new do |spec|
  spec.name          = "vundabar"
  spec.version       = Vundabar::VERSION
  spec.authors       = ["Eyiowuawi Olalekan"]
  spec.email         = ["olalekan.eyiowuawi@andela.com"]

  spec.summary       = "A simple rack-based MVC framework"
  spec.description   = "A simple rack-based MVC framework that can be used to build awesome webapps."
  spec.homepage      = "https://www.github.com/andela-oeyiowuawi/Vundabar"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["vundabar"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "rack", "~> 1.0"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "activesupport"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "factory_girl"
  spec.add_runtime_dependency "pry"
  spec.add_development_dependency "coveralls"
  spec.add_runtime_dependency "sqlite3"
  spec.add_runtime_dependency "tilt"
end
