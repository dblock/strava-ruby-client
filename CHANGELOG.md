### 2.1.1 (Next)

* [#81](https://github.com/dblock/strava-ruby-client/pull/80): Adds back activity photos [@dillon-co](https://github.com/dillon-co)

### 2.1.0 (2024/3/20)

* [#80](https://github.com/dblock/strava-ruby-client/pull/80): Removes default values for Faraday's SSL settings `ca_file` and `ca_path` - [@dblock](https://github.com/dblock).

### 2.0.0 (2023/6/22)

* [#77](https://github.com/dblock/strava-ruby-client/pull/77): Drops unsupported endpoint/method `activity_photos` - [@simonneutert](https://github.com/simonneutert).
* [#62](https://github.com/dblock/strava-ruby-client/pull/68): Drops `Activity#type` attribute as it is being deprecated by Strava, dropping `Activity#type_emoji` with it - [@simonneutert](https://github.com/simonneutert).
* [#23](https://github.com/dblock/strava-ruby-client/pull/23): Failed uploads raise Strava::Errors::UploadError - [@ylecuyer](https://github.com/ylecuyer), [@simonneutert](https://github.com/simonneutert).
* [#69](https://github.com/dblock/strava-ruby-client/pull/69): Raises `Strava::Api::RatelimitError`, when API ratelimit exceeded - [@simonneutert](https://github.com/simonneutert).
* [#74](https://github.com/dblock/strava-ruby-client/pull/74): Fixes serialization causing `stack level too deep` - [@simonneutert](https://github.com/simonneutert).
* [#75](https://github.com/dblock/strava-ruby-client/pull/75): Fixes DangerBot deprecation warning for `check` of TOC - [@simonneutert](https://github.com/simonneutert).

### 1.0.0 (2022/12/29)

* [#48](https://github.com/dblock/strava-ruby-client/pull/55): Removed `client.running_races` - [@simonneutert](https://github.com/simonneutert).
* [#56](https://github.com/dblock/strava-ruby-client/pull/56): Removed `client.segment_leaderboard` - [@simonneutert](https://github.com/simonneutert).
* [#58](https://github.com/dblock/strava-ruby-client/pull/58): Update Faraday to `>= 2.0` - [@schinery](https://github.com/schinery).
* [#58](https://github.com/dblock/strava-ruby-client/pull/58): Removed support for Ruby 2.5 and 2.6 - [@schinery](https://github.com/schinery).
* [#58](https://github.com/dblock/strava-ruby-client/pull/58): Upgraded Robocop to 1.3.0 - [@schinery](https://github.com/schinery).
* [#59](https://github.com/dblock/strava-ruby-client/pull/59): Removed deprecated `athlete.email` field - [@francordie](https://github.com/francordie).
* [#63](https://github.com/dblock/strava-ruby-client/pull/63): Added `activity.sport_type` for Strava API V3 specifications - [@simonneutert](https://github.com/simonneutert).
* [#61](https://github.com/dblock/strava-ruby-client/pull/61): Adds ratelimit as a property of model(s) - [@simonneutert](https://github.com/simonneutert), [@adamwolf](https://github.com/adamwolf).

### 0.4.3 (2022/03/21)

* [#51](https://github.com/dblock/strava-ruby-client/pull/51): Ensure support for large Integer IDs - [@simonneutert](https://github.com/simonneutert).
* [#53](https://github.com/dblock/strava-ruby-client/pull/53): Upgraded to RuboCop 1.26.0 - [@dblock](https://github.com/dblock).
* [#46](https://github.com/dblock/strava-ruby-client/pull/46): Added missing `activity:read` scope from `strava-oauth-token` - [@xaviershay](https://github.com/xaviershay).

### 0.4.2 (2021/10/03)

* [#45](https://github.com/dblock/strava-ruby-client/pull/45): Added `Gear#frame_type` `#retired` `#weight` - [@deuber](https://github.com/deuber).

### 0.4.1 (2021/07/11)

* [#37](https://github.com/dblock/strava-ruby-client/pull/38): Added `Club#club_events` - [@simonneutert](https://github.com/simonneutert).
* [#34](https://github.com/dblock/strava-ruby-client/pull/34): Added `Athlete#ftp` - [@virae](https://github.com/virae).

### 0.4.0 (2020/05/09)

* [#29](https://github.com/dblock/strava-ruby-client/pull/29): Cache `Faraday::Connection` for persistent adapters - [@dblock](https://github.com/dblock).
* [#30](https://github.com/dblock/strava-ruby-client/pull/30): Require Faraday >= 1.0 - [@dblock](https://github.com/dblock).

### 0.3.2 (2020/03/28)

* [#26](https://github.com/dblock/strava-ruby-client/pull/26): Corrected `Strava::Webhooks.config.endpoint` - [@dblock](https://github.com/dblock).
* Automatically convert `before` and `after` arguments of `Strava::Api::Client#athlete_activities` from `Time` to `Integer` - [@dblock](https://github.com/dblock).
* [#18](https://github.com/dblock/strava-ruby-client/pull/18): Testing against Ruby 2.5.3 and 2.6.0 - [@lucianosousa](https://github.com/lucianosousa).
* [#18](https://github.com/dblock/strava-ruby-client/pull/18): Upgraded Rubocop to 0.61.1 - [@lucianosousa](https://github.com/lucianosousa).
* [#21](https://github.com/dblock/strava-ruby-client/pull/21): Include headers in error response - [@jameschevalier](https://github.com/jameschevalier).

### 0.3.1 (2018/12/05)

* Added `Strava::Api::Client#activity_photos` - [@dblock](https://github.com/dblock).
* [#2](https://github.com/dblock/strava-ruby-client/issues/2): Added `Strava::Api::Client#deauthorize` - [@dblock](https://github.com/dblock).
* [#15](https://github.com/dblock/strava-ruby-client/issues/15): Added `strava-oauth-token` and `strava-webhooks` to gem executables - [@dblock](https://github.com/dblock).
* Fix: `Strava::Models::Activity#total_elevation_gain` no returns blank for negative and zero elevation differences - [@dblock](https://github.com/dblock).
* Fix: `Strava::Models::Split#distance` and `total_elevation_gain` incorrect for `Strava::Models::Activity#splits_standard` - [@dblock](https://github.com/dblock).

### 0.3.0 (2018/12/03)

* Added webhooks support - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#athlete_zones`, `athlete_stats` and `update_athlete` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#club`, `club_admins` and `club_members` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#gear` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#route`, `athlete_routes`, `export_route_gpx` and `export_route_tcx`  - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#running_race` and `running_races`  - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#segment_effort` and `segment_efforts`  - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#explore_segments`, `segment_leaderboard`, `starred_segments`, `segment` and `star_segment`  - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#activity_streams`, `segment_effort_streams` and `segment_streams`  - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#create_upload` and `upload` - [@dblock](https://github.com/dblock).
* [#9](https://github.com/dblock/strava-ruby-client/issues/9): All methods that take `id` can take it directly or via options hash - [@dblock](https://github.com/dblock).

### 0.2.0 (2018/11/27)

* Added `Strava::Api::Client#activity` with segments, photos, similar activities, trends, laps and gear - [@dblock](https://github.com/dblock).
* Added `Activity#type_emoji` and `Activity#strava_url` - [@dblock](https://github.com/dblock).
* Added `Athlete#name` and `Athlete#strava_url` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#athlete_clubs` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#club_activities` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#create_activity` and `Strava::Api::Client#update_activity` - [@dblock](https://github.com/dblock).
* Added `Strava::Api::Client#activity_comments`, `activity_kudos`, `activity_zones` and `activity_laps` - [@dblock](https://github.com/dblock).
* Added support for converting and displaying activity distance, elevation, speed and pace - [@dblock](https://github.com/dblock).
* [#5](https://github.com/dblock/strava-ruby-client/issues/5): Added support for pagination - [@dblock](https://github.com/dblock).
* [#6](https://github.com/dblock/strava-ruby-client/issues/6): The `strava-oauth-token` tool has been renamed and will handle the redirect in the browser - [@dblock](https://github.com/dblock).

### 0.1.0 (2018/11/23)

* Initial public release, OAuth, current Athlete and Athlete Activities - [@dblock](https://github.com/dblock).
