# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'fzen'
  spec.version       = '0.1.0'
  spec.authors       = ['User']
  spec.summary       = 'Fuzzy file finder with actions'
  spec.description   = 'A fast fuzzy file finder with configurable actions (open, delete, copy path)'
  spec.homepage      = 'https://github.com/user/fzen'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.files         = ['fzen', 'lib/fzen.rb']
  spec.executables   = ['fzen']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
