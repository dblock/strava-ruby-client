# Strava Ruby Client<!-- omit in toc -->

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Test](https://github.com/dblock/strava-ruby-client/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/dblock/strava-ruby-client/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/dblock/strava-ruby-client/badge.svg?branch=master)](https://coveralls.io/github/dblock/strava-ruby-client?branch=master)

A complete Ruby client for the [Strava API v3](https://developers.strava.com).

It supports OAuth with refresh tokens, webhooks, pagination and rate limits, provides rich Strava models with distance, time and elevation helpers, and is tested with actual Strava data.

## Table of Contents<!-- omit in toc -->

- [Installation](#installation)
- [Usage](#usage)
  - [Get a Token](#get-a-token)
  - [Make Requests](#make-requests)
  - [Paginate](#paginate)
  - [Handle Errors](#handle-errors)
  - [More](#more)
- [Configuration](#configuration)
  - [Web Client Options](#web-client-options)
  - [API Client Options](#api-client-options)
  - [OAuth Client Options](#oauth-client-options)
  - [Webhooks Client Options](#webhooks-client-options)
- [Tools](#tools)
  - [Strava OAuth Token](#strava-oauth-token)
  - [Strava Refresh Token](#strava-refresh-token)
- [Users](#users)
- [Resources](#resources)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'strava-ruby-client'
```

Run `bundle install`.

## Usage

### Get a Token

Strava API calls require an OAuth access token. The token shown on [My API Application](https://www.strava.com/settings/api) can't read your activities, so use [strava-oauth-token](#strava-oauth-token) to obtain one with more scopes, or implement the [OAuth workflow](docs/USAGE.md#oauth) in your application.

```bash
STRAVA_CLIENT_ID=... STRAVA_CLIENT_SECRET=... strava-oauth-token
```

Save the `refresh_token` in a secure location and use [strava-refresh-token](#strava-refresh-token) to get a new access token when it expires.

### Make Requests

```ruby
client = Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'])

athlete = client.athlete # => Strava::Models::DetailedAthlete
athlete.firstname # => 'Daniel'

activity = client.activity(1946417534) # => Strava::Models::DetailedActivity
activity.name # => 'TCS NYC Marathon 2018'
activity.distance_in_miles_s # => '26.26mi'
activity.strava_url # => 'https://www.strava.com/activities/1946417534'
```

### Paginate

List APIs return one page by default. Pass `per_page` to retrieve all pages, `limit` to stop after a number of items, or a block to process items as pages arrive.

```ruby
client.athlete_activities(per_page: 30, limit: 50) do |activity|
  activity # => Strava::Models::SummaryActivity
end
```

### Handle Errors

HTTP errors raise [Strava::Errors::Fault](lib/strava/errors/fault.rb), and exceeding rate limits raises [Strava::Errors::RatelimitError](lib/strava/errors/ratelimit_error.rb). Every response exposes rate limits.

```ruby
begin
  athlete = client.athlete
  athlete.http_response.ratelimit.fifteen_minutes_remaining # => 590
rescue Strava::Errors::Fault => e
  e.message # => 'Authorization Error'
end
```

### More

See [docs/USAGE.md](docs/USAGE.md) for all APIs, including activities, athletes, clubs, gear, routes, segments, streams, uploads, OAuth, webhooks, pagination, rate limits and errors.

## Configuration

### Web Client Options

You can configure web client options used in the OAuth and API clients, globally.

```ruby
Strava::Web::Client.configure do |config|
  config.user_agent = 'Strava Ruby Client/3.0'
end
```

The following settings are supported.

| setting            | description                                                                       |
| ------------------ | --------------------------------------------------------------------------------- |
| user_agent         | User-agent, defaults to _Strava Ruby Client/version_.                             |
| proxy              | Optional HTTP proxy.                                                              |
| ca_path            | Optional SSL certificates path.                                                   |
| ca_file            | Optional SSL certificates file.                                                   |
| logger             | Optional `Logger` instance that logs HTTP requests.                               |
| timeout            | Optional open/read timeout in seconds.                                            |
| open_timeout       | Optional connection open timeout in seconds.                                      |
| log_formatter      | Optional `Faraday::Logging::Formatter` class, e.g. `Strava::Web::LogFormatter`.   |
| filter_credentials | Filter client secrets, tokens and codes from logs and errors, defaults to `true`. |

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

| setting      | description                                         |
| ------------ | --------------------------------------------------- |
| access_token | Access token to pass in the `Authorization` header. |
| endpoint     | Defaults to `https://www.strava.com/api/v3`.        |

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

| setting       | description                                 |
| ------------- | ------------------------------------------- |
| client_id     | Application client ID.                      |
| client_secret | Application client secret.                  |
| endpoint      | Defaults to `https://www.strava.com/oauth`. |

### Webhooks Client Options

The Webhooks client inherits web client options and provides additional application configuration. These can be configured globally or for a client instance.

```ruby
Strava::Webhooks.configure do |config|
  config.client_id = "..." # Strava client ID
  config.client_secret = "..." # Strava client secret
end
```

```ruby
client = Strava::Webhooks::Client.new(
  client_id: "...",
  client_secret: "...",
  user_agent: "..."
)
```

The following settings are supported.

| setting       | description                                  |
| ------------- | -------------------------------------------- |
| client_id     | Application client ID.                       |
| client_secret | Application client secret.                   |
| endpoint      | Defaults to `https://www.strava.com/api/v3`. |

## Tools

For a complete set of command-line tools, check out [strava-ruby-cli](https://github.com/dblock/strava-ruby-cli) built on top of this gem.

### Strava OAuth Token

Use [strava-oauth-token](bin/strava-oauth-token) to obtain a token from the command-line. This will open a new browser window, navigate to Strava, request the appropriate permissions, then handle OAuth in a local redirect. The token type, refresh token, access token and token expiration will be displayed in the browser.

```bash
STRAVA_CLIENT_ID=... STRAVA_CLIENT_SECRET=... strava-oauth-token
```

### Strava Refresh Token

Use [strava-refresh-token](bin/strava-refresh-token) to obtain a token from the command-line using an existing refresh token.

```bash
STRAVA_CLIENT_ID=... STRAVA_CLIENT_SECRET=... STRAVA_API_REFRESH_TOKEN=... strava-refresh-token
```

## Users

- [Slava: Strava integration with Slack](https://slava.playplay.io), [source](https://github.com/dblock/slack-strava).
- [Strada: Strava integration with Discord](https://strada.playplay.io), [source](https://github.com/dblock/discord-strava).
- [Jekyll Blog at run.dblock.org](https://run.dblock.org), [source](https://github.com/dblock/run.dblock.org)
- [Secret Strava](https://steele.blue/secret-strava/), [source](https://github.com/mattdsteele/secret-strava)

## Resources

- [Strava API Documentation](https://developers.strava.com)
- [Writing a New Strava API Ruby Client](https://code.dblock.org/2018/11/27/writing-a-new-strava-api-ruby-client.html)
- [Dealing with Strava API OAuth Token Migration](https://code.dblock.org/2018/11/17/dealing-with-strava-api-token-migration.html)
- [Auto-Publishing Strava Runs to Github Pages](https://code.dblock.org/2018/02/17/auto-publishing-strava-runs-to-github-pages.html)
- [Strava Command-Line Client](https://github.com/dblock/strava-ruby-cli)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md), [CHANGELOG](CHANGELOG.md), [UPGRADING](UPGRADING.md) and [RELEASING](RELEASING.md).

## Copyright and License

Copyright (c) 2018-2025, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
