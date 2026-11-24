# frozen_string_literal: true

source 'http://rubygems.org'

gemspec

group :development, :test do
  gem 'appraisal'
  gem 'benchmark-ips'
  gem 'csv'
  gem 'danger-changelog', '~> 0.8.0'
  gem 'danger-pr-comment'
  gem 'danger-toc', '~> 0.2.0'
  gem 'dotenv'
  gem 'faraday-retry'
  gem 'gpx'
  gem 'multi_xml'
  gem 'polylines'
  gem 'pry'
  gem 'rake'
  gem 'rspec'
  gem 'tcx'
  gem 'vcr'
  gem 'webmock'
  gem 'webrick', '~> 1.9'
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'commonmarker', '~> 2.10', require: false
    gem 'ruby-gem-release', '0.9.0', require: false
  end
end

group :test do
  gem 'simplecov'
  gem 'simplecov-lcov', require: false
end
