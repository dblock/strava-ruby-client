# frozen_string_literal: true

# Tests the gem against the two major json releases that are relevant to
# https://github.com/dblock/strava-ruby-client/issues/113: json < 3.0, where
# JSON.parse accepts a positional options hash (the form Faraday's :json
# response middleware uses), and json >= 3.0, where JSON.parse only accepts
# keyword arguments and Faraday's call raises an ArgumentError.
appraise 'json-2' do
  gem 'json', '~> 2.3'
end

appraise 'json-3' do
  gem 'json', '~> 3.0'
end
