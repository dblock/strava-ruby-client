# Upgrading Strava-Ruby-Client

### Upgrading to >= 0.5.0

Every Model was upgraded with the possibility to check the API ratelimit that was send as a response from the Strava API.

```ruby
{
  limit: limit,
  usage: usage,
  total_day: total_day,
  total_day_usage: total_day_usage,
  total_day_remaining: total_day_remaining,
  fiveteen_minutes: fiveteen_minutes, # limit for 15 minute range
  fiveteen_minutes_usage: fiveteen_minutes_usage, # used past 15 minutes
  fiveteen_minutes_remaining: fiveteen_minutes_remaining,
}
```

Every API call returning a single instance and _not multiple instances_, like `client.athlete` will respond to `#http_response`  
`Strava::Models::Athlete#http_response`

‼️ Please bear in mind, that you might stumble and fall, when trying to access `http_response` and `ratelimit` info for `activity_comments` being an  
`Array[Strava::Models::Comments]`!

```ruby
comments = client.activity_comments(id: 123_456_789)

# comments == Array<Strava::Models::Comment>
comments.http_response.ratelimit.limit #=> NoMethodError

comment = comments.first
comment.http_response.ratelimit.limit unless comment.nil?
```

### Upgrading to >= 0.4.0

#### Faraday 1.0

The library was upgraded to require Faraday 1.0 or newer. Change all references to `Faraday::Error::ResourceNotFound` or `Faraday::Error::ConnectionFailed` to `Faraday::ConnectionFailed` and `Faraday::ResourceNotFound` respectively.

See [#30](https://github.com/dblock/strava-ruby-client/pull/30) for more details.
