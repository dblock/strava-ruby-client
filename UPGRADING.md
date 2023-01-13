# Upgrading Strava-Ruby-Client

### Upgrading to >= 2.0.0

- Dropping `Activity` attribute `type` and `type_emoji` in favor of `sport_type` and `sport_type_emoji`. Creating or updating an `Activity` requires you to use `sport_type` instead of `type`, as refered in the [README](README.md#create-an-activity). For details visit the official [Strava docs: Create Activity](https://developers.strava.com/docs/reference/#api-Activities-createActivity) and the entry from June 15, 2022 in [Strava's V3 API Changelog](https://developers.strava.com/docs/changelog/).

### Upgrading to >= 1.0.0

- API request will now raise `Strava::Web::RaiseResponseError` instead of `::Strava::Web::Response::RaiseError`
- Using `get`, `post`, `put`, `delete` directly, changed from `Faraday::Response` to `Strava::Web::Response` as return value.  
  In order to access the `Faraday::Reponse` or `Faraday::Reponse#body` you need to call `.response` or `.response.body`.
- Paginated API paths now return `Strava::Api::Pagination`, which is a new wrapper class for the returned collection of entries.

### Upgrading to >= 0.4.0

#### Faraday 1.0

The library was upgraded to require Faraday 1.0 or newer. Change all references to `Faraday::Error::ResourceNotFound` or `Faraday::Error::ConnectionFailed` to `Faraday::ConnectionFailed` and `Faraday::ResourceNotFound` respectively.

See [#30](https://github.com/dblock/strava-ruby-client/pull/30) for more details.
