# Strava Ruby Client

[![Gem Version](https://badge.fury.io/rb/strava-ruby-client.svg)](https://badge.fury.io/rb/strava-ruby-client)
[![Test](https://github.com/dblock/strava-ruby-client/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/dblock/strava-ruby-client/actions/workflows/test.yml)

A complete Ruby client for the [Strava API v3](https://developers.strava.com).

Unlike other clients, including [strava-api-v3](https://github.com/jaredholdcroft/strava-api-v3), provides complete OAuth refresh token flow support, webhooks support, a richer first class interface to Strava models, conversion helpers for distance, time and elevation, natively supports pagination, implements more consistent error handling and is built with thorough test coverage using actual Strava data.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Activities](#activities)
    - [Create an Activity](#create-an-activity)
    - [Get Activity](#get-activity)
    - [List Activity Photos](#list-activity-photos)
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
    - [List Club Events](#list-club-events)
    - [List Club Administrators](#list-club-administrators)
    - [Get Club](#get-club)
    - [List Club Members](#list-club-members)
    - [List Athlete Clubs](#list-athlete-clubs)
  - [Gears](#gears)
    - [Get Equipment](#get-equipment)
  - [Routes](#routes)
    - [Export Route GPX](#export-route-gpx)
    - [Export Route TCX](#export-route-tcx)
    - [Get Route](#get-route)
    - [List Athlete Routes](#list-athlete-routes)
  - [Running Races](#running-races)
    - [Get Running Race](#get-running-race)
  - [Segment Efforts](#segment-efforts)
    - [List Segment Efforts](#list-segment-efforts)
    - [Get Segment Effort](#get-segment-effort)
  - [Segments](#segments)
    - [Explore Segments](#explore-segments)
    - [List Starred Segments](#list-starred-segments)
    - [Get Segment](#get-segment)
    - [Star Segment](#star-segment)
  - [Streams](#streams)
    - [Get Activity Streams](#get-activity-streams)
    - [Get Segment Effort Streams](#get-segment-effort-streams)
    - [Get Segment Streams](#get-segment-streams)
  - [Uploads](#uploads)
    - [Upload Activity](#upload-activity)
    - [Get Upload](#get-upload)
  - [Pagination](#pagination)
  - [OAuth](#oauth)
    - [OAuth Workflow](#oauth-workflow)
    - [Deauthorize](#deauthorize)
    - [Command Line OAuth Workflow](#command-line-oauth-workflow)
  - [Webhooks](#webhooks)
  - [Ratelimit](#ratelimit)
    - [Exceeded Ratelimit](#exceeded-ratelimit)
- [Configuration](#configuration)
  - [Web Client Options](#web-client-options)
  - [API Client Options](#api-client-options)
  - [OAuth Client Options](#oauth-client-options)
  - [Webhooks Client Options](#webhooks-client-options)
- [Errors](#errors)
- [Tools](#tools)
  - [Strava OAuth Token](#strava-oauth-token)
- [Users](#users)
- [Resources](#resources)
- [Upgrading](#upgrading)
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
  sport_type: 'Run',
  start_date_local: Time.now,
  elapsed_time: 1234, # in seconds
  description: 'Test run.',
  distance: 1000 # in meters
)

activity.name # => 'Afternoon Run'
activity.strava_url # => 'https://www.strava.com/activities/1982980795'
```

See [Strava::Models::Activity](lib/strava/models/activity.rb) for all available properties.

#### Get Activity

Returns the given activity that is owned by the authenticated athlete.

```ruby
activity = client.activity(1982980795)

activity.name # => 'Afternoon Run'
activity.strava_url # => 'https://www.strava.com/activities/1982980795'
```

See [Strava::Models::Activity](lib/strava/models/activity.rb) for all available properties.

Use `map.summary_polyline` and combine with [polylines](https://github.com/joshuaclayton/polylines) to parse the activity map and to construct a Google maps URL with start and end markers.

```ruby
map = activity.map # => Strava::Models::Map

decoded_summary_polyline = Polylines::Decoder.decode_polyline(map.summary_polyline)
start_latlng = decoded_summary_polyline[0]
end_latlng = decoded_summary_polyline[-1]

google_maps_api_key = ENV['GOOGLE_STATIC_MAPS_API_KEY']

google_image_url = "https://maps.googleapis.com/maps/api/staticmap?maptype=roadmap&path=enc:#{map.summary_polyline}&key=#{google_maps_api_key}&size=800x800&markers=color:yellow|label:S|#{start_latlng[0]},#{start_latlng[1]}&markers=color:green|label:F|#{end_latlng[0]},#{end_latlng[1]}"
```

See [Strava::Models::Map](lib/strava/models/map.rb) for all available properties.

#### List Activity Photos

Returns the photos on the given activity. This API is undocumented.

```ruby
photos = client.activity_photos(1982980795) # => Array[Strava::Models::Photo]

photo = photos.first # => Strava::Models::Photo

photo.id # => nil
photo.unique_id # => '65889142-538D-4EE5-96F5-3DC3B773B1E3'
photo.urls # => { '0' => 'https://dgtzuqphqg23d.cloudfront.net/eb4DMJ2hJW3k_g9URZEMfaJ8rZfHagrNlZRuEZz0osU-29x64.jpg' }
photo.athlete_id # => 26_462_176
photo.activity_id # => 1_946_417_534
photo.activity_name # => 'TCS NYC Marathon 2018'
photo.created_at # => Time
photo.uploaded_at # => Time
photo.sizes # => { '0' => [29, 64] }
photo.default_photo # => false
```

See [Strava::Models::Photo](lib/strava/models/photo.rb) for all available properties.

#### List Activity Comments

Returns the comments on the given activity.

```ruby
comments = client.activity_comments(1982980795) # => Array[Strava::Models::Comment]

comment = comments.first # => Strava::Models::Comment

comment.text # => 'Молодчина!'
comment.athlete.username # => 'zolotov'
```

See [Strava::Models::Comment](lib/strava/models/comment.rb) for all available properties.

#### List Activity Kudoers

Returns the athletes who kudoed an activity identified by an identifier.

```ruby
kudoers = client.activity_kudos(1982980795) # => Array[Strava::Models::Athlete]

kodoer = kudoers.first # => Strava::Models::Athlete

kudoer.username # => 'zolotov'
```

See [Strava::Models::Athlete](lib/strava/models/athlete.rb) for all available properties.

#### List Activity Laps

Returns the laps of an activity identified by an identifier.

```ruby
laps = client.activity_laps(1982980795) # => Array[Strava::Models::Lap]

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
activity.sport_type_emoji # => '🏃'
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

Returns the zones of a given activity.

```ruby
zones = client.activity_zones(1982980795) # => Array[Strava::Models::ActivityZone]

zone = zones.first # => Strava::Models::ActivityZone
zones.type # => 'heartrate'

distribution_buckets = activity_zone.distribution_buckets # => Array[Strava::Models::TimedZoneRange]

distribution_bucket = distribution_buckets.first # => Strava::Models::TimedZoneRange

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
  sport_type: 'Run',
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
athlete_stats = client.athlete_stats(26462176) # => Strava::Models::ActivityStats

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
activities = client.club_activities(108605) # => Array[Strava::Models::Activity]

activity = activities.first # => Strava::Models::Activity

activity.name # => 'Afternoon Run'
```

See [Strava::Models::Activity](lib/strava/models/activity.rb) for all available properties. Note that Strava does not return activity or athlete ID via this API.

#### List Club Events

Retrieve recent Events from a specific club.

```ruby
events = client.club_events(108605) # => Array[Strava::Models::ClubEvent]

event = events.first # => Strava::Models::ClubEvent

event.title # => 'First Group Event Ever! Yippieh!'
```

See [Strava::Models::ClubEvent](lib/strava/models/club_event.rb) for all available properties.

#### List Club Administrators

Returns a list of the administrators of a given club.

```ruby
admins = client.club_admins(108605) # => Array[Strava::Models::ClubAdmin]

admin = admins.first # => Strava::Models::ClubAdmin
admin.name # => 'Peter Ciaccia'
```

See [Strava::Models::ClubAdmin](lib/strava/models/club_admin.rb) for all available properties.

#### Get Club

Returns a given club using its identifier.

```ruby
club = client.club(108605) # => Strava::Models::Club

club.name # => 'NYRR'
```

See [Strava::Models::Club](lib/strava/models/club.rb) for all available properties.

#### List Club Members

Returns a list of the members of a given club.

```ruby
members = client.club_members(108605) # => Array[Strava::Models::ClubMember]

member = members.first # => Strava::Models::ClubMember
member.name # => 'Peter Ciaccia'
```

See [Strava::Models::ClubMember](lib/strava/models/club_member.rb) for all available properties.

#### List Athlete Clubs

Returns a list of the clubs whose membership includes the authenticated athlete.

```ruby
clubs = client.athlete_clubs # => Array[Strava::Models::Club]

club = clubs.first # => Strava::Models::Club

activity.name # => 'NYRR'
activity.strava_url # => 'https://www.strava.com/clubs/nyrr'
```

See [Strava::Models::Club](lib/strava/models/club.rb) for all available properties.

### Gears

#### Get Equipment

Returns an equipment using its identifier.

```ruby
gear = client.gear(id: 'b2338517') # => Strava::Models::Gear

gear.id # => 'b2338517'
gear.name # => 'Trek'
gear.distance # => 380939.0
gear.distance_s # => '380.94km'
gear.brand_name # => 'Trek'
gear.model_name # => 'Madone'
gear.description # => 'white'
gear.primary # => 'false'
gear.frame_type # => '3'
gear.weight # => '9'
gear.retired # => 'false'
```

See [Strava::Models::Gear](lib/strava/models/gear.rb) for all available properties.

### Routes

#### Export Route GPX

Returns [GPS Exchange Format](https://en.wikipedia.org/wiki/GPS_Exchange_Format) (GPX) data of the route. Combine with [multi_xml](https://github.com/sferik/multi_xml) or [gpx](https://github.com/dougfales/gpx) to parse it.

```ruby
data = client.export_route_gpx(16341573) # => String

require 'multi_xml'
xml = MultiXml.parse(data) # => parsed GPX

require 'gpx'
gpx = GPX::GPXFile.new(gpx_data: data) # => GPX::GPXFile

gpx.name # => 'Lower Manhattan Loop'
gpx.description # => 'My usual long run when I am too lazy to go to Central Park.'
gpx.tracks # => Array[GPX::Track]
```

#### Export Route TCX

Returns a [Training Center XML](https://en.wikipedia.org/wiki/Training_Center_XML) (TCX) data of the route. Combine with [multi_xml](https://github.com/sferik/multi_xml) to parse it.

```ruby
data = client.export_route_tcx(16341573) # => String

require 'multi_xml'
xml = MultiXml.parse(data) # => parsed TCX
```

#### Get Route

Returns a route using its identifier.

```ruby
route = client.route(16341573) # => Strava::Models::Route

route.name # => 'Lower Manhattan Loop'
route.description # => 'My usual long run when I am too lazy to go to Central Park.'
```

See [Strava::Models::Route](lib/strava/models/route.rb) for all available properties.

#### List Athlete Routes

Returns a list of the routes by athlete ID.

```ruby
routes = client.athlete_routes(26462176) # => Array[Strava::Models::Route]

route = routes.first # => Strava::Models::Route

route.name # => 'Lower Manhattan Loop'
route.description # => 'My usual long run when I am too lazy to go to Central Park.'
route.moving_time_in_hours_s # => '1h21m5s'
```

See [Strava::Models::Route](lib/strava/models/route.rb) for all available properties.

### Running Races

#### Get Running Race

Returns a running race for a given identifier.

```ruby
running_race = client.running_race(1577) # => Strava::Models::RunningRace

running_race.name # => 'Walt Disney World Marathon 10k'
running_race.distance # => 10_000.0
running_race.distance_s # => '10km'
running_race.city # => 'Orlando'
running_race.state # => 'FL'
running_race.country # => 'United States'
running_race.strava_url # => 'https://www.strava.com/running-races/2018-walt-disney-world-marathon-10k'
running_race.website_url # => 'https://www.rundisney.com/disneyworld-marathon/'
```

See [Strava::Models::RunningRace](lib/strava/models/running_race.rb) for all available properties.

### Segment Efforts

#### List Segment Efforts

Returns a set of the authenticated athlete's segment efforts for a given segment.

```ruby
segment_efforts = client.segment_efforts(1109718)

segment_effort = segment_efforts.first # => Strava::Models::SegmentEffort

segment_effort.name # => 'E 14th St Climb'
segment_effort.activity # => Strava::Models::Activity
segment_effort.athlete # => Strava::Models::Athlete
segment_effort.elapsed_time # => 116
segment_effort.distance # => 398.6
segment_effort.distance_s # => '0.4km'
segment_effort.average_heartrate # => 152.2
segment_effort.max_heartrate # => 158.0

segment_effort.achievements # => Enumerable

achievement = segment_effort.achievements.first # => Strava::Models::Achievement
achievement.rank # => 1
achievement.type # => 'pr'
achievement.type_id # => 3
```

See [Strava::Models::SegmentEffort](lib/strava/models/segment_effort.rb) and [Strava::Models::Achievement](lib/strava/models/achievement.rb) for all available properties.

#### Get Segment Effort

Returns a segment effort from an activity that is owned by the authenticated athlete.

```ruby
segment_effort = client.segment_effort(41494197089) # => Strava::Models::SegmentEffort

segment_effort.name # => 'E 14th St Climb'
segment_effort.activity # => Strava::Models::Activity
segment_effort.elapsed_time # => 116

segment_stats = segment_effort.athlete_segment_stats # => Strava::Models::SegmentStats
segment_stats.pr_elapsed_time # => 116
segment_stats.elapsed_time_in_hours_s # => '1m56s'
segment_stats.pr_date # => Date
segment_stats.effort_count # => 3
```

See [Strava::Models::SegmentEffort](lib/strava/models/segment_effort.rb) and [Strava::Models::SegmentStats](lib/strava/models/segment_stats.rb) for all available properties.

### Segments

#### Explore Segments

Returns the top 10 segments matching a specified query.

```ruby
segments = client.explore_segments(bounds: [36.372975, -94.220234, 36.415949, -94.183670], activity_type: 'running')

segment = segments.first # => Strava::Models::ExplorerSegment
segment.name # => 'Compton Gardens hill'
segment.avg_grade # => 4.6
segment.start_latlng # => [36.377702, -94.207242]
segment.end_latlng # => [36.375948, -94.207689]
segment.elev_difference # => 9.6
```

See [Strava::Models::ExplorerSegment](lib/strava/models/explorer_segment.rb) for all available properties.

#### List Starred Segments

List of the authenticated athlete's starred segments.

```ruby
segments = client.starred_segments

segment = segments.first # => Strava::Models::Segment

segment.pr_time # => 256
segment.elapsed_time_in_hours_s # => '4m16s'
segment.starred_date # => Time
segment.athlete_pr_effort # => Strava::Models::SegmentEffort
```

See [Strava::Models::Segment](lib/strava/models/segment.rb) and [Strava::Models::SegmentEffort](lib/strava/models/segment_effort.rb) for all available properties.

#### Get Segment

Returns the specified segment.

```ruby
segment = client.segment(1109718) # => Strava::Models::Segment

segment.name # => 'E 14th St Climb'
segment.city # => 'New York'
segment.state # => 'NY'
segment.country # => 'United States'
segment.map # => Strava::Models::Map
segment.effort_count # => 750
segment.athlete_count # => 206
segment.star_count # => 1
segment.athlete_segment_stats # => Strava::Models::SegmentStats
```

See [Strava::Models::Segment](lib/strava/models/segment.rb) for all available properties.

#### Star Segment

Stars/unstars the given segment for the authenticated athlete.

```ruby
segment = client.star_segment(50272077110, starred: true) # => Strava::Models::Segment

segment.name # => 'E 14th St Climb'
segment.starred # => true
```

See [Strava::Models::Segment](lib/strava/models/segment.rb) for all available properties.

### Streams

Stream APIs can return various streams by key(s).

```ruby
streams = client.segment_streams(1109718, keys: %w[distance latlng altitude]) # => Strava::Models::StrewamSet

streams.distance # => Strava::Models::Stream
streams.latlng # => Strava::Models::Stream
streams.altitude # => Strava::Models::Stream
```

#### Get Activity Streams

Returns the given activity's streams.

```ruby
streams = client.activity_streams(1946417534) # => Strava::Models::StreamSet

distance = streams.distance # => Strava::Models::Stream
distance.original_size # => 13_129
distance.resolution # => 'high'
distance.series_type # => 'distance'
distance.data # => Array[Float]
```

See [Strava::Models::StreamSet](lib/strava/models/stream_set.rb) and [Strava::Models::Stream](lib/strava/models/stream.rb) for all available properties.

#### Get Segment Effort Streams

Returns a set of streams for a segment effort completed by the authenticated athlete.

```ruby
streams = client.segment_effort_streams(41494197089)

distance = streams.distance # => Strava::Models::Stream
distance.original_size # => 117
distance.resolution # => 'high'
distance.series_type # => 'distance'
distance.data # => Array[Float]
```

See [Strava::Models::StreamSet](lib/strava/models/stream_set.rb) and [Strava::Models::Stream](lib/strava/models/stream.rb) for all available properties.

#### Get Segment Streams

Returns the given segment's streams.

```ruby
streams = client.segment_streams(1109718) # => Strava::Models::StreamSet

distance = streams.distance # => Strava::Models::Stream
distance.original_size # => 32
distance.resolution # => 'high'
distance.series_type # => 'distance'
distance.data # => Array[Float]
```

See [Strava::Models::StreamSet](lib/strava/models/stream_set.rb) and [Strava::Models::Stream](lib/strava/models/stream.rb) for all available properties.

### Uploads

#### Upload Activity

Uploads a new data file to create an activity from. To check the processing status of the uploaded file, see [Get Upload](#get-upload).

```ruby
upload = client.create_upload(
  file: Faraday::UploadIO.new('17611540601.tcx', 'application/tcx+xml'),
  name: 'Uploaded Activity',
  description: 'Uploaded by strava-ruby-client.',
  data_type: 'tcx',
  external_id: 'strava-ruby-client-upload-1'
) # => Strava::Models::Upload

upload.id # => 2136460097
upload.external_id # => 'strava-ruby-client-upload-1.tcx'
upload.error # => nil
upload.status # => 'Your activity is still being processed.'
upload.activity_id # => nil
```

See [Strava::Models::Upload](lib/strava/models/upload.rb) for all available properties.

#### Get Upload

Returns an upload for a given identifier. Raises `Strava::Errors::UploadError` if the upload was faulty and did not result in a created activity. `Strava::Errors::UploadError#upload` contains `Strava::Models::Upload` for further inspection.

```ruby
# happy path
upload = client.upload(2136460097) # => Strava::Models::Upload

upload.id # => 2_136_460_097
upload.external_id # => 'strava-ruby-client-upload-1.tcx'
upload.error # => nil
upload.status # => 'Your activity is ready.'
upload.activity_id # => 1_998_557_443
```

```ruby
# with error after upload
upload = client.upload(2136460097) 
begin
  while upload.processing?
    sleep 1
    upload = client.upload(2136460097)
  end
rescue Strava::Errors::UploadError => upload_error
  upload_error.status # => 200
  upload_error.error_status # => 'There was an error processing your activity.'
  upload_error.message # => '17611540601.tcx duplicate of activity 8309312818'
  
  upload_error.upload.external_id # => nil
  upload_error.upload.activity_id # => nil
  upload_error.upload.status # => 'There was an error processing your activity.'
  upload_error.upload.error # => '17611540601.tcx duplicate of activity 8309312818'
  upload_error.upload.class # => Strava::Models::UploadFailed
end
```

See [Strava::Models::Upload](lib/strava/models/upload.rb) for all available properties.  
See [Strava::Errors::UploadError](lib/strava/errors/upload_failed_error.rb) for all available properties.

### Pagination

Some Strava APIs, including [athlete-activities](#list-athlete-activities) support pagination when supplying an optional `page` and `per_page` parameter. By default the client retrieves one page of data, which Strava currently defaults to 30 items. You can paginate through more data by supplying a block and an optional `per_page` parameter. The underlying implementation makes page-sized calls and increments the `page` argument.

```ruby
client.athlete_activities(per_page: 30) do |activity|
  activity # => Strava::Models::Activity
end
```

### OAuth

#### OAuth Workflow

Obtain a redirect URL using an instance of `Strava::OAuth::Client`.

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

response.access_token # => String, new access token
response.refresh_token # => String, new refresh token
response.expires_at # => Time, new timestamp when the access token expires
```

#### Deauthorize

Revoke access to an athlete's data using an instance of `Strava::API::Client`.

```ruby
authorization = client.deauthorize

authorization.access_token # => String, access token being revoked
```

#### Command Line OAuth Workflow

The OAuth process is web-based and you cannot obtain a token from a Strava client ID and secret without user intervention. You can, however, start a local web server to handle the OAuth redirect and open a browser from the command-line.

See [strava-oauth-token](/bin/strava-oauth-token) or [strava-ruby-cli](https://github.com/dblock/strava-ruby-cli) for an example.

### Webhooks

Strava provides a [Webhook Event API](https://developers.strava.com/docs/webhooks/).

A complete example that handles subscription creation, deletion and handling can be found in [strava-webhooks](bin/strava-webhooks). Run `strava-webhooks` to see current registrations, `strava-webhooks handle` to run an HTTP server that handles both challenges and event data, `strava-webhooks create [url]` to create a new subscription and `strava-webhooks delete [id]` to delete it.

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
event.updates # => { 'sport_type' => 'Walk' }
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
client.delete_push_subscription(131300) # => nil
```

### Ratelimit

Every API call's HTTP Reponse Content, be it a single Model or a list (via pagination), can be accessed by using `#http_response`.

`client.athlete` #=> `Strava::Models::Athlete#http_response`

`client.activity_comments(id: 1234567)` #=> `Array<Strava::Models::Comment>#http_response`

`http_response` itself is a `Strava::Web::ApiResponse` class. Ratelimits are accessed via this class using `Strava::Web::ApiResponse#ratelimit`. See the examples given below:

```ruby
comments = client.activity_comments(id: 123_456_789)

# comments == Array<Strava::Models::Comment>
comments.http_response.ratelimit.to_h
```

```ruby
athlete = client.athlete # => Strava::Models::Athlete
athlete.http_response.ratelimit
```

The following properties are available on Strava::Api::Ratelimit.

- `limit`
- `limit?`
- `usage`
- `fifteen_minutes`
- `fifteen_minutes_usage`
- `fifteen_minutes_remaining`
- `total_day`
- `total_day_usage`
- `total_day_remaining`
- `to_h`
- `to_s`

You can access the Hash containing all limits by calling `to_h`.

```ruby
# athlete.http_response.ratelimit.to_h
{
  limit: limit,
  usage: usage,
  total_day: total_day,
  total_day_usage: total_day_usage,
  total_day_remaining: total_day_remaining,
  fifteen_minutes: fifteen_minutes,
  fifteen_minutes_usage: fifteen_minutes_usage,
  fifteen_minutes_remaining: fifteen_minutes_remaining
}
```

#### Exceeded Ratelimit

Strava answers with HTTP status code 429, when ratelimits are exceeded. This will in return raise `Strava::Errors::RatelimitError`.

```ruby
error.is_a?(Strava::Errors::RatelimitError) #=> true
error.ratelimit.is_a?(Strava::Api::Ratelimit) #=> true
# see Strava::Api::Ratelimit
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

| setting      | description                                           |
| ------------ | ----------------------------------------------------- |
| user_agent   | User-agent, defaults to _Strava Ruby Client/version_. |
| proxy        | Optional HTTP proxy.                                  |
| ca_path      | Optional SSL certificates path.                       |
| ca_file      | Optional SSL certificates file.                       |
| logger       | Optional `Logger` instance that logs HTTP requests.   |
| timeout      | Optional open/read timeout in seconds.                |
| open_timeout | Optional connection open timeout in seconds.          |

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

| setting      | description                                         |
| ------------ | --------------------------------------------------- |
| access_token | Access token to pass in the `Authorization` header. |
| endpoint     | Defaults to `https://www.strava.com/api/v3`.        |

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

| setting       | description                                 |
| ------------- | ------------------------------------------- |
| client_id     | Application client ID.                      |
| client_secret | Application client secret.                  |
| endpoint      | Defaults to `https://www.strava.com/oauth`. |

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

| setting       | description                                  |
| ------------- | -------------------------------------------- |
| client_id     | Application client ID.                       |
| client_secret | Application client secret.                   |
| endpoint      | Defaults to `https://www.strava.com/api/v3`. |

## Errors

All errors that return HTTP codes 400-600 result in either `Faraday::ResourceNotFound`, `Faraday::ConnectionFailed` or [Strava::Errors::Fault](lib/strava/errors/fault.rb) exceptions.

```ruby
begin
  client.oauth_token(code: 'invalid')
rescue Strava::Errors::Fault => e
  e.message # => Bad Request
  e.errors # => [{ 'code' => 'invalid', 'field' => 'code', 'resource' => 'RequestToken' }]
  e.headers # => { "status" => "403 Bad Request", "x-ratelimit-limit" => "600,30000", "x-ratelimit-usage" => "314,27536" }
end
```

## Tools

For a complete set of command-line tools, check out [strava-ruby-cli](https://github.com/dblock/strava-ruby-cli) built on top of this gem.

### Strava OAuth Token

Use [strava-oauth-token](bin/strava-oauth-token) to obtain a token from the command-line. This will open a new browser window, navigate to Strava, request the appropriate permissions, then handle OAuth in a local redirect. The token type, refresh token, access token and token expiration will be displayed in the browser.

```bash
STRAVA_CLIENT_ID=... STRAVA_CLIENT_SECRET=... strava-oauth-token
```

## Users

- [Slava: Strava integration with Slack](https://slava.playplay.io), [source](https://github.com/dblock/slack-strava).
- [Jekyll Blog at run.dblock.org](https://run.dblock.org), [source](https://github.com/dblock/run.dblock.org)
- [Secret Strava](https://steele.blue/secret-strava/), [source](https://github.com/mattdsteele/secret-strava)

## Resources

- [Strava API Documentation](https://developers.strava.com)
- [Writing a New Strava API Ruby Client](https://code.dblock.org/2018/11/27/writing-a-new-strava-api-ruby-client.html)
- [Dealing with Strava API OAuth Token Migration](https://code.dblock.org/2018/11/17/dealing-with-strava-api-token-migration.html)
- [Auto-Publishing Strava Runs to Github Pages](https://code.dblock.org/2018/02/17/auto-publishing-strava-runs-to-github-pages.html)
- [Strava Command-Line Client](https://github.com/dblock/strava-ruby-cli)

## Upgrading

See [UPGRADING](UPGRADING.md).

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2018, [Daniel Doubrovkine](https://twitter.com/dblockdotorg) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
