Strava Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Build Status](https://travis-ci.org/dblock/strava-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/strava-ruby-client)

A newer Ruby client for the [Strava API v3](https://developers.strava.com). Unlike [strava-api-v3](https://github.com/jaredholdcroft/strava-api-v3) provides a first class interface to Strava models and more robust error handling.

# Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Errors](#errors)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'strava-ruby-client'
```

Run `bundle install`.

## Usage

### Configure

```ruby
Strava::OAuth.configure do |config|
  config.client_id = "..." # Strava client ID
  config.client_secret = "..." # Strava client secret
end
```

### OAuth

Obtain a redirect URL for the user.

```ruby
redirect_url = client.authorize_url(
  redirect_uri: 'https://example.com/oauth',
  approval_prompt: 'force',
  response_type: 'code',
  scope: 'activity:read_all',
  state: 'magic'
)
```

Once the user is redirected to your application, perform a token exchange to obtain a refresh and access token.

```ruby
response = client.oauth_token(code: 'code from redirect url')

response # => Strava::Models::Token

response.access_token # access token
response.refresh_token # refresh token
response.expires_at # timestamp when the access token expires
response.athlete # => Strava::Models::Athlete
```

See [Strava authentication documentation](https://developers.strava.com/docs/authentication/), [Strava::Models::Token](lib/strava/models/token.rb) and [Strava::Models::Athlete](lib/strava/models/athlete.rb) for details.

## Errors

TODO

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
