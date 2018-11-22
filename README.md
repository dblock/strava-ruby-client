Strava Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Build Status](https://travis-ci.org/dblock/strava-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/strava-ruby-client)

A newer Ruby client for the [Strava API v3](https://developers.strava.com).

Unlike [strava-api-v3](https://github.com/jaredholdcroft/strava-api-v3) provides a first class interface to Strava models and more consistent error handling.

# Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [OAuth](#oauth)
  - [API](#api)
    - [Athlete](#athlete)
- [Configuration](#configuration)
  - [Web Client Options](#web-client-options)
  - [OAuth Client Options](#oauth-client-options)
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

### OAuth

Obtain a redirect URL.

```ruby
client = Strava::OAuth::Client.new(
  client_id: "12345",
  client_secret: "12345678987654321"
)

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
response = client.oauth_token(code: '1234556789901234567890')

response # => Strava::Models::Token

response.access_token # access token
response.refresh_token # refresh token
response.expires_at # timestamp when the access token expires
response.athlete # => Strava::Models::Athlete
```

See [Strava authentication documentation](https://developers.strava.com/docs/authentication/), [Strava::Models::Token](lib/strava/models/token.rb) and [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available fields in the response.

### API

```ruby
client = Strava::Api::Client.new(
  access_token: "12345678987654321"
)
```

#### Athlete

Get currently logged-in athlete.

```ruby
client.athlete # => Strava::Models::Athlete
```

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available fields.

## Configuration

### Web Client Options

You can configure web client options used in the OAuth and API clients, globally.

```ruby
Strava::Web::Client.configure do |config|
  config.user_agent = 'Strava Ruby Client/1.0'
end
```

The following settings are supported.

setting             | description
--------------------|------------
user_agent          | User-agent, defaults to _Strava Ruby Client/version_.
proxy               | Optional HTTP proxy.
ca_path             | Optional SSL certificates path.
ca_file             | Optional SSL certificates file.
logger              | Optional `Logger` instance that logs HTTP requests.
timeout             | Optional open/read timeout in seconds.
open_timeout        | Optional connection open timeout in seconds.

### OAuth Client Options

The OAuth client inherits web client options and provides additional application configuration. These can be configured globally or for a client instance.

```ruby
Strava::OAuth.configure do |config|
  config.client_id = "..." # Strava client ID
  config.client_secret = "..." # Strava client secret
end
```

```ruby
client = Strava::OAuth::Client.new(
  client_id: "...",
  client_secret: "...",
  user_agent: "..."
)
```

The following settings are supported.

setting             | description
--------------------|------------
client_id           | Application client ID.
client_secret       | Application client secret.
endpoint            | Defaults to `https://www.strava.com/oauth/`.

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::Error::ResourceNotFound`, `Faraday::Error::ConnectionFailed` or `Faraday::ClientError` exceptions.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
