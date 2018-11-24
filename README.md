Strava Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Build Status](https://travis-ci.org/dblock/strava-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/strava-ruby-client)

A newer Ruby client for the [Strava API v3](https://developers.strava.com).

Unlike [strava-api-v3](https://github.com/jaredholdcroft/strava-api-v3) provides complete OAuth refresh token flow support, a richer first class interface to Strava models, natively supports pagination and implements more consistent error handling.

# Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [API](#api)
    - [Athlete](#athlete)
    - [Athlete Activities](#athlete-activities)
    - [Athlete Clubs](#athlete-clubs)
    - [Pagination](#pagination)
  - [OAuth](#oauth)
- [Configuration](#configuration)
  - [Web Client Options](#web-client-options)
  - [API Client Options](#api-client-options)
  - [OAuth Client Options](#oauth-client-options)
- [Errors](#errors)
- [Tools](#tools)
  - [OAuth Token](#oauth-token)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'strava-ruby-client'
```

Run `bundle install`.

## Usage

### API

Use an access token obtained from [My API Application](https://www.strava.com/settings/api) in the Strava UI, the [oauth-token tool](#oauth-token) or the [OAuth Workflow](#oauth) in your application.

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

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available properties.

#### Athlete Activities

Get currently logged-in athlete activities.

```ruby
activities = client.athlete_activities # => Array[Strava::Models::Activity]

activity = activities.first # => Strava::Models::Activity

activity.name # => 'Afternoon Run'
activity.strava_url # => 'https://www.strava.com/activities/1477353766'
activity.type_emoji # => '🏃'
activity.distance_s # => '14.01mi'
activity.moving_time_in_hours_s # => '2h6m26s'
activity.elapsed_time_in_hours_s # => '2h8m6s'
activity.pace_s # => '9m02s/mi'
activity.speed_s # => '6.6mph'
activity.total_elevation_gain_s # => '475.4ft'
```

See [Strava::Models::Activity](lib/strava/models/activity.rb) for all available properties.

#### Athlete Clubs

Get currently logged-in athlete clubs.

```ruby
clubs = client.athlete_clubs # => Array[Strava::Models::Club]

club = clubs.first # => Strava::Models::Activity

activity.name # => 'NYRR'
activity.strava_url # => 'https://www.strava.com/clubs/nyrr'
```

See [Strava::Models::Club](lib/strava/models/club.rb) for all available properties.

#### Pagination

Some Strava APIs, including [athlete_activities](#athlete-activities) support pagination when supplying an optional `page` and `per_page` parameter. By default the client retrieves one page of data, which Strava currently defaults to 30 items. You can paginate through more data by supplying a block and an optional `per_page` parameter. The underlying implementation makes page-sized calls and increments the `page` argument.

```ruby
client.athlete_activities(per_page: 30) do |activity|
  activity # => Strava::Models::Activity
end
```

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

See [Strava authentication documentation](https://developers.strava.com/docs/authentication/), [Strava::Models::Token](lib/strava/models/token.rb) and [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available properties in the response.

If the access token is expired, refresh it before making any requests. You will get back all new tokens.

```ruby
response = client.oauth_token(
  refresh_token: '...',
  grant_type: 'refresh_token'
)

response.access_token # new access token
response.refresh_token # new refresh token
response.expires_at # new timestamp when the access token expires
```

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

### API Client Options

The API client inherits web client options and provides additional application configuration. These can be configured globally or for a client instance.

```ruby
Strava::API.configure do |config|
  config.access_token = "..." # Strava access token
end
```

```ruby
client = Strava::API::Client.new(
  access_token: "...",
  user_agent: "..."
)
```

The following settings are supported.

setting             | description
--------------------|------------
access_token        | Access token to pass in the `Authorization` header.
endpoint            | Defaults to `https://www.strava.com/api/v3`.

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
endpoint            | Defaults to `https://www.strava.com/oauth`.

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::Error::ResourceNotFound`, `Faraday::Error::ConnectionFailed` or [Strava::Errors::Fault](lib/strava/errors/fault.rb) exceptions.

```ruby
begin
  client.oauth_token(code: 'invalid')
rescue Strava::Errors::Fault => e
  e.message # => Bad Request
  e.errors # => [{ 'code' => 'invalid', 'field' => 'code', 'resource' => 'RequestToken' }]
end
```

## Tools

### OAuth Token

Use [bin/oauth-token](bin/outh-token) to obtain a token from the command-line.

```bash
$ STRAVA_CLIENT_ID=... STRAVA_CLIENT_SECRET=... bundle exec bin/oauth-token.rb

Opening browser at https://www.strava.com/oauth/authorize?...
Copy paste the code from the redirect URL: 1234556789901234567890
token_type: Bearer
refresh_token: 013612374123716234842346234
access_token: 7348562936591928461923619823
expires_at: 2018-11-23 16:25:52 -0500
```

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
