# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'

Bundler.setup :default, :development

# Releases run through GitHub Actions with ruby-gem-release, see RELEASING.md.
if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
  require_relative 'script/release'
  StravaRelease.workflow.install_tasks

  %w[release release:rubygem_push release:source_control_push].each do |name|
    Rake::Task[name].clear
    desc 'Disabled, releases run through GitHub Actions, see RELEASING.md.'
    task(name) { abort "#{name} is disabled, releases run through GitHub Actions, see RELEASING.md." }
  end
end

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

desc 'Run benchmarks, see benchmark/client.rb.'
task :benchmark do
  ruby 'benchmark/client.rb'
end

task default: %i[spec]
