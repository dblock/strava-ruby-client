# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'

Bundler.setup :default, :development

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb'].exclude('spec/integration/**/*_spec.rb')
end

RSpec::Core::RakeTask.new(:'spec:integration') do |spec|
  spec.pattern = FileList['spec/integration/**/*_spec.rb']
end

# Rubocop lives in its own Gemfile (gemfiles/rubocop.gemfile), not the main
# Gemfile, so it doesn't constrain dependency resolution there (see
# https://github.com/dblock/strava-ruby-client/issues/113). Run it with
# `BUNDLE_GEMFILE=gemfiles/rubocop.gemfile bundle exec rubocop`.

task default: %i[spec]
