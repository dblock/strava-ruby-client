# frozen_string_literal: true

# Tests the gem against the two major json releases relevant to
# https://github.com/dblock/strava-ruby-client/issues/113.
appraise 'json-2' do
  gem 'json', '~> 2.3'
end

appraise 'json-3' do
  gem 'json', '~> 3.0'
end

# Hashie 6 no longer defines Dash/Trash property readers that conflict
# with existing methods, such as `map`, `count`, `min` and `max`.
appraise 'hashie-5' do
  gem 'hashie', '~> 5.0'
end

appraise 'hashie-6' do
  gem 'hashie', '>= 6.0'
end
