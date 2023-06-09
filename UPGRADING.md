# Upgrading Strava-Ruby-Client

### Upgrading to >= 1.1.0

- The method `Client#activity_photos` to retrieve an activity's photos has been removed. The Strava API offers no official support for this. See [#76](https://github.com/dblock/strava-ruby-client/issues/76) for details.

### Upgrading to >= 1.0.0

- API request will now raise `Strava::Web::RaiseResponseError` instead of `::Strava::Web::Response::RaiseError`
- Using `get`, `post`, `put`, `delete` directly, changed from `Faraday::Response` to `Strava::Web::Response` as return value.  
  In order to access the `Faraday::Reponse` or `Faraday::Reponse#body` you need to call `.response` or `.response.body`.
- Paginated API paths now return `Strava::Api::Pagination`, which is a new wrapper class for the returned collection of entries.

### Upgrading to >= 0.4.0

#### Faraday 1.0

The library was upgraded to require Faraday 1.0 or newer. Change all references to `Faraday::Error::ResourceNotFound` or `Faraday::Error::ConnectionFailed` to `Faraday::ConnectionFailed` and `Faraday::ResourceNotFound` respectively.

See [#30](https://github.com/dblock/strava-ruby-client/pull/30) for more details.
