# Upgrading Strava-Ruby-Client

### Upgrading to >= 2.0.0

- Dropping `Activity` attribute `type` and `type_emoji` in favor of `sport_type` and `sport_type_emoji`. Creating or updating an `Activity` requires you to use `sport_type` instead of `type`, as refered in the [README](README.md#create-an-activity). For details visit the official [Strava docs: Create Activity](https://developers.strava.com/docs/reference/#api-Activities-createActivity) and the entry from June 15, 2022 in [Strava's V3 API Changelog](https://developers.strava.com/docs/changelog/).
- Uploading a file using `create_upload` requires you to check its process, using `client.updload('your-unique-upload-id')`. A successful upload does just mean, that the file was accepted. The Processing of the file is an independent process on Strava's side. From now on, `client.updload('your-unique-upload-id')` will raise `Strava::Errors::UploadError`, if Strava failed processing the file, e.g. it being a duplicate.
- Exceeded Ratelimits (HTTP Status: 429) do now raise a customized Error `Strava::Errors::RatelimitError`. You can use the `Strava::Api::Ratelimit` object coming with the error, for further inspection of your current ratelimits.
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
