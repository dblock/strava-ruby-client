# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity', vcr: { cassette_name: 'client/activity_ride' } do
  include_context 'with API client'
  it 'returns activity' do
    activity = client.activity(id: 7_142_833_299)

    expect(activity).to be_a Strava::Models::DetailedActivity
    expect(activity.id).to eq 7_142_833_299
    expect(activity.resource_state).to eq 3
    expect(activity.athlete).to be_a Strava::Models::MetaAthlete
    expect(activity.athlete.id).to eq 26_462_176
    expect(activity.athlete.resource_state).to eq 1
    expect(activity.name).to eq '#CycleForSurvival'
    expect(activity.description).to eq '🇫🇷🥰'
    expect(activity.distance).to eq 101_529.0
    expect(activity.distance_in_miles).to eq 63.08707473
    expect(activity.distance_in_miles_s).to eq '63.09mi'
    expect(activity.distance_in_yards).to eq 111_033.12969
    expect(activity.distance_in_yards_s).to eq '111033yd'
    expect(activity.distance_in_meters).to eq 101_529.0
    expect(activity.distance_in_meters_s).to eq '101529m'
    expect(activity.distance_in_kilometers).to eq 101.529
    expect(activity.distance_in_kilometers_s).to eq '101.53km'
    expect(activity.distance_s).to eq '101.53km'

    expect(activity.moving_time).to eq 2432
    expect(activity.elapsed_time).to eq 2432
    expect(activity.moving_time_in_hours_s).to eq '40m32s'
    expect(activity.elapsed_time_in_hours_s).to eq '40m32s'
    expect(activity.pace_per_mile_s).to eq '9m20s/mi'
    expect(activity.pace_per_100_yards_s).to eq '0m32s/100yd'
    expect(activity.pace_per_100_meters_s).to eq '0m35s/100m'
    expect(activity.pace_per_kilometer_s).to eq '5m48s/km'
    expect(activity.pace_s).to eq '5m48s/km'
    expect(activity.average_speed_kilometer_per_hour_s).to eq '10.3km/h'
    expect(activity.average_speed_miles_per_hour_s).to eq '6.4mph'
    expect(activity.average_speed_s).to eq '10.3km/h'

    expect(activity.total_elevation_gain).to eq 24.0
    expect(activity.total_elevation_gain_in_feet).to eq 78.74016
    expect(activity.total_elevation_gain_in_meters).to eq 24.0
    expect(activity.total_elevation_gain_in_meters_s).to eq '24m'
    expect(activity.total_elevation_gain_in_feet_s).to eq '78.7ft'
    expect(activity.total_elevation_gain_s).to eq '24m'

    expect(activity.sport_type).to eq 'Ride'
    expect(activity.workout_type).to eq 10
    expect(activity.external_id).to eq 'garmin_push_8823414069'
    expect(activity.upload_id).to eq 7_605_104_623
    expect(activity.start_date).to eq Time.parse('2022-05-14 18:21:19 UTC')
    expect(activity.timezone).to eq '(GMT-05:00) America/New_York'
    expect(activity.start_date_local).to eq Time.parse('2022-05-14 14:21:19 -0400')

    expect(activity.utc_offset).to eq(-14_400.0)
    expect(activity.start_latlng.lat).to eq 49.197681
    expect(activity.start_latlng.lng).to eq 7.883777
    expect(activity.start_latlng).to eq [49.197681, 7.883777]
    expect(activity.end_latlng).to eq [49.034333, 7.94529]
    expect(activity.location_city).to be_nil
    expect(activity.location_state).to be_nil
    expect(activity.location_country).to eq 'USA'
    expect(activity.achievement_count).to eq 0
    expect(activity.kudos_count).to eq 3
    expect(activity.comment_count).to eq 0
    expect(activity.athlete_count).to eq 1
    expect(activity.photo_count).to eq 0

    map = activity.map
    expect(map).to be_a Strava::Models::Map
    expect(map.id).to eq 'a7142833299'
    expect(map.resource_state).to eq 3
    expect(Polylines::Decoder.decode_polyline(map.summary_polyline).size).to eq 123

    expect(activity.trainer).to be true
    expect(activity.commute).to be false
    expect(activity.manual).to be false
    expect(activity.private).to be false
    expect(activity.visibility).to eq 'everyone'
    expect(activity.flagged).to be false
    expect(activity.gear_id).to be_nil
    expect(activity.from_accepted_tag).to be false
    expect(activity.average_speed).to eq 2.874059649655219
    expect(activity.max_speed).to eq 2.681
    expect(activity.has_heartrate).to be true
    expect(activity.average_heartrate).to eq 120.7
    expect(activity.max_heartrate).to eq 145.0
    expect(activity.heartrate_opt_out).to be false
    expect(activity.display_hide_heartrate_option).to be true
    expect(activity.elev_high).to be_nil
    expect(activity.elev_low).to be_nil
    expect(activity.pr_count).to eq 0
    expect(activity.total_photo_count).to eq 1
    expect(activity.has_kudoed).to be false
    expect(activity.suffer_score).to eq 9.0
    expect(activity.calories).to eq 377.0

    expect(activity.splits_metric).to be_nil
    expect(activity.splits_standard).to be_nil

    expect(activity.laps).to be_a Enumerable
    lap = activity.laps.first
    expect(lap).to be_a Strava::Models::Lap
    expect(lap.id).to eq 23_656_870_985
    expect(lap.resource_state).to eq 2
    expect(lap.name).to eq 'Lap 1'
    expect(lap.activity).to be_a Strava::Models::MetaActivity
    expect(lap.athlete).to be_a Strava::Models::MetaAthlete
    expect(lap.elapsed_time).to eq 2432
    expect(lap.moving_time).to eq 2432
    expect(lap.start_date).to eq Time.parse('2022-05-14 18:21:19 UTC')
    expect(lap.start_date_local).to eq Time.parse('2022-05-14 14:21:19 -0400')
    expect(lap.distance).to eq 0.0
    expect(lap.start_index).to eq 0
    expect(lap.end_index).to eq 803
    expect(lap.total_elevation_gain).to eq 22.0
    expect(lap.average_speed).to eq 0.0
    expect(lap.max_speed).to eq 0.0
    expect(lap.average_heartrate).to eq 120.7
    expect(lap.max_heartrate).to eq 145.0
    expect(lap.lap_index).to eq 1
    expect(lap.split).to eq 1
    expect(lap.pace_zone).to be_nil

    expect(activity.gear).to be_nil
    expect(activity.device_name).to eq 'Garmin Forerunner 945'

    expect(activity.segment_efforts).to eq([])

    expect(activity.photos).to be_a Strava::Models::PhotosSummary
    photos = activity.photos
    expect(photos.use_primary_photo).to be true
    expect(photos.count).to eq 1
    photo = photos.primary
    expect(photo).to be_a Strava::Models::PhotosSummaryPrimary
    expect(photo.unique_id).to eq '54FF646F-9E6A-4BDC-845E-11553B814383'
    expect(photo.urls).to eq(
      '100' => 'https://dgtzuqphqg23d.cloudfront.net/DS-vccluHuiI0udXQo_39w7srsPlAP7bzdpzPuqshvo-128x128.jpg',
      '600' => 'https://dgtzuqphqg23d.cloudfront.net/DS-vccluHuiI0udXQo_39w7srsPlAP7bzdpzPuqshvo-768x768.jpg'
    )
    expect(photo.source).to eq 1

    expect(activity.embed_token).to eq '0bc42b4f28b86156819a6a7092bc20279ded7dcb'

    expect(activity.available_zones).to eq %w[heartrate]
  end

  it 'returns activity by id' do
    activity = client.activity(7_142_833_299)
    expect(activity).to be_a Strava::Models::DetailedActivity
    expect(activity.id).to eq 7_142_833_299
  end
end
