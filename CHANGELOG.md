### 3.0.0 (Next)

* [#97](https://github.com/dblock/strava-ruby-client/pull/97): Adds `bin/strava-refresh-token` - [@dblock](https://github.com/dblock).
* [#96](https://github.com/dblock/strava-ruby-client/pull/96): Updates and refactor models to spec - [@dblock](https://github.com/dblock).
* [#94](https://github.com/dblock/strava-ruby-client/pull/94): Adds video fields to `Strava::Models::Photo` - [@dblock](https://github.com/dblock).
* [#92](https://github.com/dblock/strava-ruby-client/pull/92): Fixes `Hashie::Trash` serialization warning for `object_id` of `Strava::Webhooks::Models::Event` - [@simonneutert](https://github.com/simonneutert).
* [#95](https://github.com/dblock/strava-ruby-client/pull/95): Fixes `club_events` returning `Strava::Models::ClubEvent` with an empty string in `created_at` - [@dblock](https://github.com/dblock).
* [#98](https://github.com/dblock/strava-ruby-client/pull/98): Changes all `latlng` properties to return an instance of `Strava::Models::LatLng` - [@dblock](https://github.com/dblock).
* [#99](https://github.com/dblock/strava-ruby-client/pull/99): Adds support for `page_size` on `activity_comments` and adds `limit` - [@dblock](https://github.com/dblock).
* [#93](https://github.com/dblock/strava-ruby-client/pull/93): Updates GitHub Actions workflows - [@simonneutert](https://github.com/simonneutert).
* Your contribution here.

### 2.3.0 (2025/10/16)

* [#91](https://github.com/dblock/strava-ruby-client/pull/91): Respects `Faraday::Response::RaiseError::DEFAULT_OPTIONS` when raising errors - [@dblock](https://github.com/dblock).
* [#87](https://github.com/dblock/strava-ruby-client/pull/87): Prepares v2.3.0 by improving the event specs - [@simonneutert](https://github.com/simonneutert).
* [#86](https://github.com/dblock/strava-ruby-client/pull/86): Adds description to club event model - [@tobiaszwaszak](https://github.com/tobiaszwaszak).

### 2.2.0 (2024/9/17)

* [#83](https://github.com/dblock/strava-ruby-client/pull/83): Adds back activity photos - [@dillon-co](https://github.com/dillon-co).
* [#84](https://github.com/dblock/strava-ruby-client/pull/84): Adds back activity photos (finished PR #83) - [@simonneutert](https://github.com/simonneutert).
* [#85](https://github.com/dblock/strava-ruby-client/pull/85): Lays groundwork to v3.0.0 of the gem (ruby3, newest rubocop, rubocop-rake and rubocop-rspec) - [@simonneutert](https://github.com/simonneutert).

### 2.1.0 (2024/3/20)

* [#80](https://github.com/dblock/strava-ruby-client/pull/80): Removes default values for Faraday's SSL settings `ca_file` and `ca_path` - [@dblock](https://github.com/dblock).

### 2.0.0 (2023/6/22)

* [#77](https://github.com/dblock/strava-ruby-client/pull/77): Drops unsupported `activity_photos` - [@simonneutert](https://github.com/simonneutert).
* [#62](https://github.com/dblock/strava-ruby-client/pull/68): Drops `Activity#type` attribute as it is being deprecated by Strava, dropping `Activity#type_emoji` with it - [@simonneutert](https://github.com/simonneutert).
* [#23](https://github.com/dblock/strava-ruby-client/pull/23): Raises `Strava::Errors::UploadError` on failed uploads - [@ylecuyer](https://github.com/ylecuyer), [@simonneutert](https://github.com/simonneutert).
* [#69](https://github.com/dblock/strava-ruby-client/pull/69): Raises `Strava::Api::RatelimitError`, when API ratelimit exceeded - [@simonneutert](https://github.com/simonneutert).
* [#74](https://github.com/dblock/strava-ruby-client/pull/74): Fixes serialization causing `stack level too deep` - [@simonneutert](https://github.com/simonneutert).
* [#75](https://github.com/dblock/strava-ruby-client/pull/75): Fixes DangerBot deprecation warning for `check` of TOC - [@simonneutert](https://github.com/simonneutert).

### 1.0.0 (2022/12/29)

* [#48](https://github.com/dblock/strava-ruby-client/pull/55): Removes `client.running_races` - [@simonneutert](https://github.com/simonneutert).
* [#56](https://github.com/dblock/strava-ruby-client/pull/56): Removes `client.segment_leaderboard` - [@simonneutert](https://github.com/simonneutert).
* [#58](https://github.com/dblock/strava-ruby-client/pull/58): Updates Faraday to `>= 2.0` - [@schinery](https://github.com/schinery).
* [#58](https://github.com/dblock/strava-ruby-client/pull/58): Removes support for Ruby 2.5 and 2.6 - [@schinery](https://github.com/schinery).
* [#58](https://github.com/dblock/strava-ruby-client/pull/58): Upgrades Robocop to 1.3.0 - [@schinery](https://github.com/schinery).
* [#59](https://github.com/dblock/strava-ruby-client/pull/59): Removes deprecated `athlete.email` field - [@francordie](https://github.com/francordie).
* [#63](https://github.com/dblock/strava-ruby-client/pull/63): Adds `activity.sport_type` for Strava API V3 specifications - [@simonneutert](https://github.com/simonneutert).
* [#61](https://github.com/dblock/strava-ruby-client/pull/61): Adds ratelimit as a property of model(s) - [@simonneutert](https://github.com/simonneutert), [@adamwolf](https://github.com/adamwolf).

### 0.4.3 (2022/03/21)

* [#51](https://github.com/dblock/strava-ruby-client/pull/51): Ensures support for large Integer IDs - [@simonneutert](https://github.com/simonneutert).
* [#53](https://github.com/dblock/strava-ruby-client/pull/53): Upgrades to RuboCop 1.26.0 - [@dblock](https://github.com/dblock).
* [#46](https://github.com/dblock/strava-ruby-client/pull/46): Adds missing `activity:read` scope from `strava-oauth-token` - [@xaviershay](https://github.com/xaviershay).

### 0.4.2 (2021/10/03)

* [#45](https://github.com/dblock/strava-ruby-client/pull/45): Adds `Gear#frame_type` `#retired` `#weight` - [@deuber](https://github.com/deuber).

### 0.4.1 (2021/07/11)

* [#37](https://github.com/dblock/strava-ruby-client/pull/38): Adds `Club#club_events` - [@simonneutert](https://github.com/simonneutert).
* [#34](https://github.com/dblock/strava-ruby-client/pull/34): Adds `Athlete#ftp` - [@virae](https://github.com/virae).

### 0.4.0 (2020/05/09)

* [#29](https://github.com/dblock/strava-ruby-client/pull/29): Caches `Faraday::Connection` for persistent adapters - [@dblock](https://github.com/dblock).
* [#30](https://github.com/dblock/strava-ruby-client/pull/30): Requires Faraday >= 1.0 - [@dblock](https://github.com/dblock).

### 0.3.2 (2020/03/28)

* [#26](https://github.com/dblock/strava-ruby-client/pull/26): Corrects `Strava::Webhooks.config.endpoint` - [@dblock](https://github.com/dblock).
* Automatically converts `before` and `after` arguments of `Strava::Api::Client#athlete_activities` from `Time` to `Integer` - [@dblock](https://github.com/dblock).
* [#18](https://github.com/dblock/strava-ruby-client/pull/18): Adds testing against Ruby 2.5.3 and 2.6.0 - [@lucianosousa](https://github.com/lucianosousa).
* [#18](https://github.com/dblock/strava-ruby-client/pull/18): Upgrades Rubocop to 0.61.1 - [@lucianosousa](https://github.com/lucianosousa).
* [#21](https://github.com/dblock/strava-ruby-client/pull/21): Includes headers in error response - [@jameschevalier](https://github.com/jameschevalier).

### 0.3.1 (2018/12/05)

* Adds `Strava::Api::Client#activity_photos` - [@dblock](https://github.com/dblock).
* [#2](https://github.com/dblock/strava-ruby-client/issues/2): Adds `Strava::Api::Client#deauthorize` - [@dblock](https://github.com/dblock).
* [#15](https://github.com/dblock/strava-ruby-client/issues/15): Adds `strava-oauth-token` and `strava-webhooks` to gem executables - [@dblock](https://github.com/dblock).
* Fixes `Strava::Models::Activity#total_elevation_gain` no returns blank for negative and zero elevation differences - [@dblock](https://github.com/dblock).
* Fixes `Strava::Models::Split#distance` and `total_elevation_gain` incorrect for `Strava::Models::Activity#splits_standard` - [@dblock](https://github.com/dblock).

### 0.3.0 (2018/12/03)

* Adds webhooks support - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#athlete_zones`, `athlete_stats` and `update_athlete` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#club`, `club_admins` and `club_members` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#gear` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#route`, `athlete_routes`, `export_route_gpx` and `export_route_tcx`  - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#running_race` and `running_races`  - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#segment_effort` and `segment_efforts`  - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#explore_segments`, `segment_leaderboard`, `starred_segments`, `segment` and `star_segment`  - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#activity_streams`, `segment_effort_streams` and `segment_streams`  - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#create_upload` and `upload` - [@dblock](https://github.com/dblock).
* [#9](https://github.com/dblock/strava-ruby-client/issues/9): All methods that take `id` can take it directly or via `options` hash - [@dblock](https://github.com/dblock).

### 0.2.0 (2018/11/27)

* Adds `Strava::Api::Client#activity` with segments, photos, similar activities, trends, laps and gear - [@dblock](https://github.com/dblock).
* Adds `Activity#type_emoji` and `Activity#strava_url` - [@dblock](https://github.com/dblock).
* Adds `Athlete#name` and `Athlete#strava_url` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#athlete_clubs` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#club_activities` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#create_activity` and `Strava::Api::Client#update_activity` - [@dblock](https://github.com/dblock).
* Adds `Strava::Api::Client#activity_comments`, `activity_kudos`, `activity_zones` and `activity_laps` - [@dblock](https://github.com/dblock).
* Adds support for converting and displaying activity distance, elevation, speed and pace - [@dblock](https://github.com/dblock).
* [#5](https://github.com/dblock/strava-ruby-client/issues/5): Adds support for pagination - [@dblock](https://github.com/dblock).
* [#6](https://github.com/dblock/strava-ruby-client/issues/6): Renames the `strava-oauth-token` tool and handles the redirect in the browser - [@dblock](https://github.com/dblock).

### 0.1.0 (2018/11/23)

* Initial public release, OAuth, current Athlete and Athlete Activities - [@dblock](https://github.com/dblock).
