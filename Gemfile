# frozen_string_literal: true

source 'http://rubygems.org'

gemspec

# Faraday's :json response middleware is incompatible with json >= 3.0 (see
# https://github.com/dblock/strava-ruby-client/issues/113), so pin json here
# rather than relying on rubocop's own transitive constraint. The `json-3`
# appraisal (see Appraisals) is used to track when this can be removed.
gem 'json', '~> 2.3'

group :development, :test do
  gem 'appraisal'
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
end

group :test do
  gem 'simplecov'
  gem 'simplecov-lcov', require: false
end
