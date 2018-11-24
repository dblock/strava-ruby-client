$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'strava/version'

Gem::Specification.new do |s|
  s.name = 'strava-ruby-client'
  s.bindir = 'bin'
  s.version = Strava::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/strava-ruby-client'
  s.licenses = ['MIT']
  s.summary = 'Strava API Ruby client.'
  s.add_dependency 'activesupport'
  s.add_dependency 'faraday', '>= 0.9'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'hashie'
end
