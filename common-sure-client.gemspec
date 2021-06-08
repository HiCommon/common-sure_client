# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name = 'common-sure_client'
  s.version = "0.0.1"
  s.authors = ['Common']
  s.summary = 'Sure API client'

  s.files = Dir['{config,lib}/**/*', 'Rakefile']
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '>= 1.16'
  s.add_development_dependency 'pry-byebug', '~> 3.4'
  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'vcr', '~> 5.0'
  s.add_development_dependency 'webmock', '~> 3.6'
  s.add_development_dependency 'faraday', '~> 0.15'
  s.add_development_dependency 'faraday_middleware', '~> 0.13'
  s.add_development_dependency 'rspec', '~> 3.8.0'
  s.add_development_dependency 'fuubar', '~> 2.4.1'
end
