# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'hoverfly'
  spec.version       = '0.0.2'
  spec.authors       = ['Automation Wizards']
  spec.email         = ['bjorn.ramroop@loblaw.ca']

  spec.summary       = 'Ruby wrapper for Hoverfly'
  spec.description   = 'Use this library to interact with Hoverfly in ruby'
  spec.homepage      = 'https://github.com/automation-wizards/hoverfly'
  spec.license       = 'MIT'

  spec.files         = Dir['LICENSE', 'README.md', 'lib/**/*']
  spec.bindir        = 'exe'
  spec.platform      = Gem::Platform::RUBY
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency      'httparty',               '>= 0.13.7'
  spec.add_runtime_dependency      'json',                   '>= 2.1.0'
  
  spec.add_development_dependency  'bundler',                '>= 1.11.2'
  spec.add_development_dependency  'rspec',                  '>= 3.4.0'
  spec.add_development_dependency  'pry',                    '>= 0.10.4'
end
