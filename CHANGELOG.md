### 0.3.2 (Next)

* Automatically convert `before` and `after` arguments of `Strava::Api::Client#athlete_activities` from `Time` to `Integer` - [@dblock](https://github.com/dblock).
* Your contribution here.

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
