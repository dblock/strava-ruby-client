Strava Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Build Status](https://travis-ci.org/dblock/strava-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/strava-ruby-client)

A Ruby client for the [Strava API v3](https://developers.strava.com).

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
```

A refresh token, access token, and access token expiration date will be issued upon successful authentication. The expires_at field contains the number of seconds since the Epoch when the provided access token will expire.

```json
{
  "token_type": "Bearer",
  "access_token": "987654321234567898765432123456789",
  "athlete": {

  },
  "refresh_token": "1234567898765432112345678987654321",
  "expires_at": 1531378346,
  "state": "magic"
}
```

See [Strava authentication documentation](https://developers.strava.com/docs/authentication/) for details.

## Errors

TODO

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
