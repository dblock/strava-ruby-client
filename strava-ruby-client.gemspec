# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'strava/version'

Gem::Specification.new do |s|
  s.name = 'strava-ruby-client'
  s.bindir = 'bin'
  s.executables = %w[strava-oauth-token strava-webhooks]
  s.version = Strava::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.7'
  s.required_rubygems_version = '>= 1.3.6'
  s.files = Dir['{bin,lib}/**/*'] + ['README.md', 'LICENSE.md', 'CHANGELOG.md']
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/strava-ruby-client'
  s.licenses = ['MIT']
  s.summary = 'Strava API Ruby client.'
  s.add_dependency 'activesupport'
  s.add_dependency 'faraday', '>= 2.0'
  s.add_dependency 'faraday-multipart', '>= 1.0'
  s.add_dependency 'hashie'
  s.metadata['rubygems_mfa_required'] = 'true'
end
