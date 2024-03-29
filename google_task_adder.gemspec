# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_task_adder/version'

Gem::Specification.new do |spec|
  spec.name          = "google_task_adder"
  spec.version       = GoogleTaskAdder::VERSION
  spec.authors       = ["Andrew Tolopko"]
  spec.email         = ["github@tolopko.com"]
  spec.summary       = %q{Add a task to Google Tasks.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.6"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry-plus'
  spec.add_dependency 'google-api-client'
end
