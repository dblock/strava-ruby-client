Strava Ruby Client
==================

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Build Status](https://travis-ci.org/dblock/strava-ruby-client.svg?branch=master)](https://travis-ci.org/dblock/strava-ruby-client)

A newer Ruby client for the [Strava API v3](https://developers.strava.com).

Unlike [strava-api-v3](https://github.com/jaredholdcroft/strava-api-v3) provides complete OAuth refresh token flow support, webhooks support, a richer first class interface to Strava models, natively supports pagination and implements more consistent error handling.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Activities](#activities)
    - [Create an Activity](#create-an-activity)
    - [Get Activity](#get-activity)
    - [List Activity Comments](#list-activity-comments)
    - [List Activity Kudoers](#list-activity-kudoers)
    - [List Activity Laps](#list-activity-laps)
    - [List Athlete Activities](#list-athlete-activities)
    - [Get Activity Zones](#get-activity-zones)
    - [Update Activity](#update-activity)
  - [Athletes](#athletes)
    - [Get Authenticated Athlete](#get-authenticated-athlete)
    - [Get Zones](#get-zones)
    - [Get Athlete Stats](#get-athlete-stats)
    - [Update Athlete](#update-athlete)
  - [Clubs](#clubs)
    - [List Club Activities](#list-club-activities)
    - [List Club Administrators](#list-club-administrators)
    - [Get Club](#get-club)
    - [List Club Members](#list-club-members)
    - [List Athlete Clubs](#list-athlete-clubs)
  - [Gears](#gears)
    - [Get Equipment](#get-equipment)
  - [Pagination](#pagination)
  - [OAuth](#oauth)
  - [Webhooks](#webhooks)
- [Configuration](#configuration)
  - [Web Client Options](#web-client-options)
  - [API Client Options](#api-client-options)
  - [OAuth Client Options](#oauth-client-options)
  - [Webhooks Client Options](#webhooks-client-options)
- [Errors](#errors)
- [Tools](#tools)
  - [Strava OAuth Token](#strava-oauth-token)
- [Contributing](#contributing)
- [Copyright and License](#copyright-and-license)

## Installation

Add to Gemfile.

```
gem 'strava-ruby-client'
```

Run `bundle install`.

## Usage

Use an access token obtained from [My API Application](https://www.strava.com/settings/api) in the Strava UI, the [strava-oauth-token tool](#strava-oauth-token) or the [OAuth Workflow](#oauth) in your application.

```ruby
client = Strava::Api::Client.new(
  access_token: "12345678987654321"
)
```

### Activities

#### Create an Activity

Creates a manual activity for an athlete.

```ruby
activity = client.create_activity(
  name: 'Afternoon Run',
  type: 'Run',
  start_date_local: Time.now,
  elapsed_time: 1234, # in seconds
  description: 'Test run.',
  distance: 1000 # in meters
)

activity.name # => 'Afternoon Run'
activity.strava_url # => 'https://www.strava.com/activities/1982980795'
```

#### Get Activity

Returns the given activity that is owned by the authenticated athlete, including description, photos, gear, splits, segments and laps.

```ruby
activity = client.activity(id: 1982980795)

activity.name # => 'Afternoon Run'
activity.strava_url # => 'https://www.strava.com/activities/1982980795'
```

#### List Activity Comments

Returns the comments on the given activity.

```ruby
comments = client.activity_comments(id: 1982980795) # => Array[Strava::Models::Comment]

comment = comments.first # => Strava::Models::Comment

comment.text # => 'Молодчина!'
comment.athlete.username # => 'zolotov'
```

See [Strava::Models::Comment](lib/strava/models/comment.rb) for all available properties.

#### List Activity Kudoers

Returns the athletes who kudoed an activity identified by an identifier.

```ruby
kudoers = client.activity_kudos(id: 1982980795) # => Array[Strava::Models::Athlete]

kodoer = kudoers.first # => Strava::Models::Athlete

kudoer.username # => 'zolotov'
```

#### List Activity Laps

Returns the laps of an activity identified by an identifier.

```ruby
laps = client.activity_laps(id: 1982980795) # => Array[Strava::Models::Lap]

lap = laps.first # => Strava::Models::Lap

lap.name # => 'Lap 1'
```

See [Strava::Models::Lap](lib/strava/models/lap.rb) for all available properties.


#### List Athlete Activities

Returns the currently logged-in athlete's activities.

```ruby
activities = client.athlete_activities # => Array[Strava::Models::Activity]

activity = activities.first # => Strava::Models::Activity

activity.name # => 'NYC TCS Marathon 2018'
activity.strava_url # => 'https://www.strava.com/activities/1477353766'
activity.type_emoji # => '🏃'
activity.distance_s # => '42.2km'
activity.moving_time_in_hours_s # => '3h38m5s'
activity.elapsed_time_in_hours_s # => '3h42m13s'
activity.pace_s # => '5m15s/km'
activity.pace_per_mile_s # => '8m28s/mi'
activity.speed_s # => '11.4km/h'
activity.miles_per_hour_s # => '7.1mph'
activity.total_elevation_gain_s # => '270.9m'
activity.total_elevation_gain_in_feet_s # => '888.8ft'
```

See [Strava::Models::Activity](lib/strava/models/activity.rb), [Strava::Models::Mixins::Distance](lib/strava/models/mixins/distance.rb), [Strava::Models::Mixins::Elevation](lib/strava/models/mixins/elevation.rb) and [Strava::Models::Mixins::Time](lib/strava/models/mixins/time.rb) for all available properties.

#### Get Activity Zones

Summit Feature. Returns the zones of a given activity.

```ruby
zones = client.activity_zones(id: 1982980795) # => Array[Strava::Models::ActivityZone]

zone = zones.first # => Strava::Models::ActivityZone
zones.type # => 'heartrate'

distribution_bucket = activity_zone.distribution_buckets.first # => Strava::Models::TimedZoneRange
distribution_bucket.min # => 0
distribution_bucket.max # => 123
distribution_bucket.time # => 20
```

See [Strava::Models::ActivityZone](lib/strava/models/activity_zone.rb) and [Strava::Models::TimedZoneRange](lib/strava/models/timed_zone_range.rb) for all available properties.

#### Update Activity

Update an activity.

```ruby
activity = client.update_activity(
  id: 1982980795,
  name: 'Afternoon Run (Updated)',
  type: 'Run',
  description: 'It was cold.'
)

activity.name # => 'Afternoon Run (Updated)'
activity.strava_url # => 'https://www.strava.com/activities/1982980795'
```

### Athletes

#### Get Authenticated Athlete

Returns the currently authenticated athlete.

```ruby
client.athlete # => Strava::Models::Athlete
```

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available properties.


#### Get Zones

Returns the the authenticated athlete's heart rate and power zones.

```ruby
athlete_zones = client.athlete_zones # => Strava::Models::Zones

heart_rate = athlete_zones.heart_rate # => Strava::Models::HeartRateZoneRanges
heart_rate.custom_zone # => false

zone = heart_rate.zones.first # => Strava::Models::ZoneRange
zone.min # => 0
zone.max # => 123
```

See [Strava::Models::Zones](lib/strava/models/zones.rb), [Strava::Models::HeartRateZoneRanges](lib/strava/models/heart_rate_zone_ranges.rb), [Strava::Models::PowerZoneRanges](lib/strava/models/power_zone_ranges.rb) and [Strava::Models::ZoneRange](lib/strava/models/zone_range.rb) for all available properties.

#### Get Athlete Stats

Returns the activity stats of an athlete.

```ruby
athlete_stats = client.athlete_stats(id: 26462176) # => Strava::Models::ActivityStats

recent_run_totals = athlete_stats.recent_ride_totals # => Strava::Models::ActivityTotal

recent_run_totals.count # => 7
recent_run_totals.distance # => 78049.90087890625
recent_run_totals.distance_s # => '78.05km'
recent_run_totals.moving_time # => 25647
recent_run_totals.moving_time_in_hours_s # => '7h7m27s'
recent_run_totals.elapsed_time # => 26952
recent_run_totals.elapsed_time_in_hours_s # => '7h29m12s'
recent_run_totals.elevation_gain # => 595.4644241333008
recent_run_totals.total_elevation_gain_s # => '595.5m'
recent_run_totals.achievement_count # => 19
```

See [Strava::Models::ActivityStats](lib/strava/models/activity_stats.rb) and [Strava::Models::ActivityTotal](lib/strava/models/activity_total.rb) for all available properties.

#### Update Athlete

Update the currently authenticated athlete.

```ruby
athlete = client.update_athlete(weight: 90.1) # => Strava::Models::Athlete
```

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available returned properties.

### Clubs

#### List Club Activities

Retrieve recent activities from members of a specific club.

```ruby
activities = client.club_activities(id: 108605) # => Array[Strava::Models::Activity]

activity = activities.first # => Strava::Models::Activity

activity.name # => 'Afternoon Run'
```

See [Strava::Models::Activity](lib/strava/models/activity.rb) for all available properties. Note that Strava does not return activity or athlete ID via this API.

#### List Club Administrators

Returns a list of the administrators of a given club.

```ruby
admins = client.club_admins(id: 108605) # => Array[Strava::Models::Athlete]

admin = admins.first # => Strava::Models::Athlete
admin.name # => 'Peter Ciaccia'
```

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available properties.

#### Get Club

Returns a given club using its identifier.

```ruby
club = client.club(id: 108605) # => Strava::Models::Club

club.name # => 'NYRR'
```

See [Strava::Models::Club](lib/strava/models/club.rb) for all available properties.

#### List Club Members

Returns a list of the members of a given club.

```ruby
members = client.club_members(id: 108605) # => Array[Strava::Models::Athlete]

member = members.first # => Strava::Models::Athlete
member.name # => 'Peter Ciaccia'
```

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available properties.

#### List Athlete Clubs

Returns a list of the clubs whose membership includes the authenticated athlete.

```ruby
clubs = client.athlete_clubs # => Array[Strava::Models::Club]

club = clubs.first # => Strava::Models::Activity

activity.name # => 'NYRR'
activity.strava_url # => 'https://www.strava.com/clubs/nyrr'
```

See [Strava::Models::Club](lib/strava/models/club.rb) for all available properties.

### Gears

#### Get Equipment

Returns an equipment using its identifier.

```ruby
gear = client.gear(id: 'g3844087') # => Strava::Models::Gear

gear.id # => 'g3844087'
gear.name # => 'Adidas Supernova ST'
gear.distance # => 380939.0
gear.distance_s # => '380.94km'
gear.brand_name # => 'Adidas'
gear.model_name # => 'Supernova'
gear.description # => 'My NYC TCS Marathon 2018 shoes.'
```

See [Strava::Models::Gear](lib/strava/models/gear.rb) for all available properties.

### Pagination

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

### Webhooks

Strava provides a [Webhook Event API](https://developers.strava.com/docs/webhooks/) that requires special access obtained by emailing [developers@strava.com](mailto:developers@strava.com).

A complete example that handles subscription creation, deletion and handling can be found in [strava-webhooks.rb](bin/strava-webhooks.rb), run `strava-webhooks` to see current registrations, `strava-webhooks handle` to run an HTTP server that handles both challenges and event data, `strava-webhooks create [url]` to create a new subscription and `strava-webhooks delete [id]` to delete it.

Before creating a webhook subscription you must implement and run an HTTP server that will handle a `GET` challenge at the subscription URL.

```ruby
challenge = Strava::Webhooks::Models::Challenge.new(request.query)
raise 'Bad Request' unless challenge.verify_token == 'token'
response.content_type = 'application/json'
response.body = challenge.response.to_json
```

See [Strava::Webhooks::Models::Challenge](lib/strava/webhooks/models/challenge.rb) for details.

An existing subscription must be handled in the same HTTP server's `POST` request to the subscription URL.

```ruby
event = Strava::Webhooks::Models::Event.new(JSON.parse(request.body))

event # => Strava::Webhooks::Models::Event
event.object_type # => 'activity'
event.object_id # => 1991813808
event.aspect_type # => 'update'
event.updates # => { 'type' => 'Walk' }
event.owner_id # => 29323238
event.subscription_id # => 131302
event.event_time # => DateTime
```

See [Strava::Webhooks::Models::Event](lib/strava/webhooks/models/event.rb) for details.

Subscriptions can be created, listed and deleted.

Create a client.

```ruby
client = Strava::Webhooks::Client.new(
  client_id: "12345",
  client_secret: "12345678987654321"
)
```

Create a subscription.

```ruby
subscription = client.create_push_subscription(callback_url: 'http://example.com/strava', verify_token: 'token')

subscription # => Strava::Webhooks::Models::Subscription
subscription.id # => 131300
subscription.callback_url # => 'http://example.com/strava'
```

See [Strava::Webhooks::Models::Subscription](lib/strava/webhooks/models/subscription.rb) for details.

List an existing subscription. Strava seems to only allow one.

```ruby
subscriptions = client.push_subscriptions

subscription = subscriptions.first # => Strava::Webhooks::Models::Subscription
subscription.id # => 131300
subscription.callback_url # => 'http://example.com/strava'
```

Delete an existing subscription.

```ruby
client.delete_push_subscription(id: 131300) # => nil
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

setting             | description
--------------------|------------
client_id           | Application client ID.
client_secret       | Application client secret.
endpoint            | Defaults to `https://api.strava.com/api/v3`.

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

### Strava OAuth Token

Use [strava-oauth-token](bin/strava-outh-token.rb) to obtain a token from the command-line. This will open a new browser window, navigate to Strava, request the appropriate permissions, then handle OAuth in a local redirect. The token type, refresh token, access token and token expiration will be displayed in the browser.

```bash
$ STRAVA_CLIENT_ID=... STRAVA_CLIENT_SECRET=... strava-oauth-token
```

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
