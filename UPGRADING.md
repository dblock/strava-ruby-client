# Upgrading Strava-Ruby-Client

### Upgrading to >= 0.5.0

- lose some words about Strava::Web::Response as return value of get/post/put/delete
  need to use `.reponse` or `.reponse.body` in order to access the response / response's body
- lose some words about Strava::Api::Pagination as return value of paginations

### Upgrading to >= 0.4.0

#### Faraday 1.0

The library was upgraded to require Faraday 1.0 or newer. Change all references to `Faraday::Error::ResourceNotFound` or `Faraday::Error::ConnectionFailed` to `Faraday::ConnectionFailed` and `Faraday::ResourceNotFound` respectively.

See [#30](https://github.com/dblock/strava-ruby-client/pull/30) for more details.
