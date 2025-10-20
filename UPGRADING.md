# Upgrading Strava-Ruby-Client

### Upgrading to >= 3.0.0

#### Breaking Model Changes

The models have been updated and now closer align to the API documentation.

- `Activity` was renamed to `DetailedActivity`, and `SummaryActivity`, `ClubActivity` and `MetaActivity` were added
- `Athlete` was renamed to `DetailedAthlete`, and `SummaryAthlete`, and `MetaAthlete` were added
- `Club` was renamed to `DetailedClub`, and `SummaryClub`, and `MetaClub` were added
- `Gear` was renamed to `DetailedGear` and `SummaryGear` was added
- `Photo` was renamed to `DetailedPhoto`, and `Photos` was renamed to `DetailedPhotos`, `PhotosSummary` and `PhotosSummaryPrimary` were added
- `Segment` was renamed to `DetailedSegment`, `SummarySegment` was added and `SegmentStats` was removed
- `SegmentEffort` was renamed to `DetailedSegmentEffort` and `SummarySegmentEffort` was added
- `ClubMember` was renamed to `ClubAthlete`, and `ClubAdmin` was removed
- `RunningRace` was removed, `BaseStream`, `StatsVisibility`, `SummaryPRSegmentEffort`, `UpdatableActivity`, `Xoms`, `Destination`, `LocalLegend` and `Waypoint` were added.

There are several API changes.

- **Activities:**
  - `create_activity()` now returns `DetailedActivity` instead of `Activity`
  - `activity()` now returns `DetailedActivity` instead of `Activity`
  - `activity_photos()` now returns `DetailedPhoto` instead of `Photo`
  - `activity_kudos()` now returns `SummaryAthlete` instead of `Athlete`

- **Athletes:**
  - `athlete()` now returns `DetailedAthlete` instead of `Athlete`
  - `update_athlete()` now returns `DetailedAthlete` instead of `Athlete`

- **Clubs:**
  - `club_activities()` now returns `ClubActivity` instead of `Activity`
  - `club_admins()` now returns `ClubAthlete` instead of `ClubAdmin`
  - `club()` now returns `DetailedClub` instead of `Club`
  - `club_members()` now returns `ClubAthlete` instead of `ClubMember`

- **Gears:**
  - `gear()` now returns `DetailedGear` instead of `Gear`

- **Segment Efforts:**
  - `segment_effort()` now returns `DetailedSegmentEffort` instead of `SegmentEffort`
  - `segment_efforts()` now returns `DetailedSegmentEffort` instead of `SegmentEffort`

- **Segments:**
  - `starred_segments()` now returns `SummarySegment` instead of `Segment`
  - `segment()` now returns `DetailedSegment` instead of `Segment`
  - `star_segment()` now returns `DetailedSegment` instead of `Segment`

**Removed Methods:**

- **`running_race(id)`** - The `client.running_race(id)` method has been removed along with the entire `RunningRaces` endpoint module.

See [#96](https://github.com/dblock/strava-ruby-client/pull/96) for details.

#### Latitude and Longitude are now instances of `Strava::Models::LatLng`

Properties, such as `DetailedActivity#start_latlng` are now of the `Strava::Models::LatLng` type. 

```ruby
activity.start_latlng # Strava::Models::LatLng
activity.start_latlng.to_a # [36.377702, -94.207242]
activity.start_latlng.lat # 36.377702
activity.start_latlng.lng # -94.207242
```

See [#98](https://github.com/dblock/strava-ruby-client/pull/98) for details.

#### Removed `id` from `Strava::Models::Photo`

The Strava Photos API returns `unique_id` and does not return `id`. The latter has been removed.

See [#94](https://github.com/dblock/strava-ruby-client/pull/94) for details.

#### Renamed `object_id` to `id` in `Strava::Webhooks::Models::Event`

The `Strava::Webhooks::Models::Event` model has been refactored to map the `object_id` field to `id` for consistency and to resolve `Hashie::Trash` serialization warnings.

**Breaking Change**: If you're using webhooks and accessing the `object_id` property, you must now use `id` instead.

**Before (v2.x):**
```ruby
event = Strava::Webhooks::Models::Event.new(JSON.parse(request.body))
event.object_id # => 1991813808
```

**After (v3.0.0):**
```ruby
event = Strava::Webhooks::Models::Event.new(JSON.parse(request.body))
event.id # => 1991813808
```

This change fixes the `Hashie::Trash` serialization warning that occurred when using `object_id` due to conflicts with Ruby's built-in `Object#object_id` method.

See [#92](https://github.com/dblock/strava-ruby-client/pull/92) for details.

### Upgrading to >= 2.3.0

Faraday can optionally exclude HTTP method, path and query params from the errors raised. The client implementation options will now default to `Faraday::Response::RaiseError::DEFAULT_OPTIONS` with `include_request` set to `true`. You can change this behavior by setting `Strava::Web::RaiseResponseError::DEFAULT_OPTIONS`.

```ruby
Strava::Web::RaiseResponseError::DEFAULT_OPTIONS = { include_request: false }
```

See [#91](https://github.com/dblock/strava-ruby-client/pull/91) for details.

### Upgrading to >= 2.2.0

Support for Ruby 2.x has been dropped. The minimum required Ruby version is now 3.0.0.

### Upgrading to >= 2.1.0

The change in [#80](https://github.com/dblock/strava-ruby-client/pull/80) removes default values for Faraday's SSL settings `ca_file` and `ca_path`.

If you previously relied on `OpenSSL::X509::DEFAULT_CERT_FILE` or `OpenSSL::X509::DEFAULT_CERT_DIR` to set these values, you must now do so explicitly.

```ruby
Strava::Web::Client.configure do |config|
  config.ca_file = OpenSSL::X509::DEFAULT_CERT_FILE
  config.ca_path = OpenSSL::X509::DEFAULT_CERT_DIR
end
```

or

```ruby
client = Strava::Api::Client.new(ca_file: OpenSSL::X509::DEFAULT_CERT_FILE, ca_path: OpenSSL::X509::DEFAULT_CERT_DIR)
```

### Upgrading to >= 2.0.0

- Dropping `Activity` attribute `type` and `type_emoji` in favor of `sport_type` and `sport_type_emoji`. Creating or updating an `Activity` requires you to use `sport_type` instead of `type`, as refered in the [README](README.md#create-an-activity). For details visit the official [Strava docs: Create Activity](https://developers.strava.com/docs/reference/#api-Activities-createActivity) and the entry from June 15, 2022 in [Strava's V3 API Changelog](https://developers.strava.com/docs/changelog/).
- Uploading a file using `create_upload` requires you to check its process, using `client.updload('your-unique-upload-id')`. A successful upload does just mean, that the file was accepted. The Processing of the file is an independent process on Strava's side. From now on, `client.updload('your-unique-upload-id')` will raise `Strava::Errors::UploadError`, if Strava failed processing the file, e.g. it being a duplicate.
- Exceeded Ratelimits (HTTP Status: 429) do now raise a customized Error `Strava::Errors::RatelimitError`. You can use the `Strava::Api::Ratelimit` object coming with the error, for further inspection of your current ratelimits.
- The method `Client#activity_photos` to retrieve an activity's photos has been removed. The Strava API offers no official support for this. See [#76](https://github.com/dblock/strava-ruby-client/issues/76) for details.
- The method `Client#activity_photos` to retrieve an activity's photos has been added back. The Strava API does actually offer undocumented support for this. It's just finicky. See [this discussion](https://communityhub.strava.com/t5/developer-discussions/download-all-photos-of-my-own-activities/m-p/11262) for details.


### Upgrading to >= 1.0.0

- API request will now raise `Strava::Web::RaiseResponseError` instead of `::Strava::Web::Response::RaiseError`
- Using `get`, `post`, `put`, `delete` directly, changed from `Faraday::Response` to `Strava::Web::Response` as return value.  
  In order to access the `Faraday::Reponse` or `Faraday::Reponse#body` you need to call `.response` or `.response.body`.
- Paginated API paths now return `Strava::Api::Pagination`, which is a new wrapper class for the returned collection of entries.

### Upgrading to >= 0.4.0

#### Faraday 1.0

The library was upgraded to require Faraday 1.0 or newer. Change all references to `Faraday::Error::ResourceNotFound` or `Faraday::Error::ConnectionFailed` to `Faraday::ConnectionFailed` and `Faraday::ResourceNotFound` respectively.

See [#30](https://github.com/dblock/strava-ruby-client/pull/30) for details.
