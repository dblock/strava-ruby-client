# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity', vcr: { cassette_name: 'client/activity_ride' } do
  include_context 'API client'
  it 'returns activity' do
    activity = client.activity(id: 3_958_491_750)

    expect(activity).to be_a Strava::Models::Activity
    expect(activity.id).to eq 3_958_491_750
    expect(activity.resource_state).to eq 3
    expect(activity.athlete).to be_a Strava::Models::Athlete
    expect(activity.athlete.id).to eq 24_776_507
    expect(activity.athlete.resource_state).to eq 1
    expect(activity.name).to eq 'Bitche, please 🥳'
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

    expect(activity.moving_time).to eq 12_634
    expect(activity.elapsed_time).to eq 14_965
    expect(activity.moving_time_in_hours_s).to eq '3h30m34s'
    expect(activity.elapsed_time_in_hours_s).to eq '4h9m25s'
    expect(activity.pace_per_mile_s).to eq '3m20s/mi'
    expect(activity.pace_per_100_yards_s).to eq '0m11s/100yd'
    expect(activity.pace_per_100_meters_s).to eq '0m12s/100m'
    expect(activity.pace_per_kilometer_s).to eq '2m04s/km'
    expect(activity.pace_s).to eq '2m04s/km'
    expect(activity.kilometer_per_hour_s).to eq '28.9km/h'
    expect(activity.miles_per_hour_s).to eq '18.0mph'
    expect(activity.speed_s).to eq '28.9km/h'

    expect(activity.total_elevation_gain).to eq 1036.0
    expect(activity.total_elevation_gain_in_feet).to eq 3398.95024
    expect(activity.total_elevation_gain_in_meters).to eq 1036.0
    expect(activity.total_elevation_gain_in_meters_s).to eq '1036m'
    expect(activity.total_elevation_gain_in_feet_s).to eq '3399ft'
    expect(activity.total_elevation_gain_s).to eq '1036m'

    expect(activity.type).to eq 'Ride'
    expect(activity.sport_type).to eq 'Ride'
    expect(activity.workout_type).to eq 12
    expect(activity.external_id).to eq '2020-08-24-070352-ELEMNT BOLT 3038-451-0.fit'
    expect(activity.upload_id).to eq 4_237_396_253
    expect(activity.start_date).to eq Time.new(2020, 8, 24, 7, 3, 53, '-00:00').utc
    expect(activity.timezone).to eq '(GMT+01:00) Europe/Berlin'
    expect(activity.start_date_local).to eq Time.new(2020, 8, 24, 9, 3, 53, '+02:00')

    expect(activity.utc_offset).to eq(7_200.0)
    expect(activity.start_latlng).to eq [49.197681, 7.883777]
    expect(activity.end_latlng).to eq [49.034333, 7.94529]
    expect(activity.location_city).to be nil
    expect(activity.location_state).to be nil
    expect(activity.location_country).to eq 'Deutschland'
    expect(activity.start_latitude).to be nil
    expect(activity.start_longitude).to be nil
    expect(activity.achievement_count).to eq 1
    expect(activity.kudos_count).to eq 70
    expect(activity.comment_count).to eq 3
    expect(activity.athlete_count).to eq 3
    expect(activity.photo_count).to eq 0

    map = activity.map
    expect(map).to be_a Strava::Models::Map
    expect(map.id).to eq 'a3958491750'
    expect(map.resource_state).to eq 3
    expect(Polylines::Decoder.decode_polyline(map.summary_polyline).size).to eq 292

    expect(activity.trainer).to be false
    expect(activity.commute).to be false
    expect(activity.manual).to be false
    expect(activity.private).to be false
    expect(activity.visibility).to eq 'everyone'
    expect(activity.flagged).to be false
    expect(activity.gear_id).to eq 'b6827635'
    expect(activity.from_accepted_tag).to be false
    expect(activity.average_speed).to eq 8.036
    expect(activity.max_speed).to eq 20.5
    expect(activity.has_heartrate).to be true
    expect(activity.average_heartrate).to eq 144.8
    expect(activity.max_heartrate).to eq 175.0
    expect(activity.heartrate_opt_out).to be false
    expect(activity.display_hide_heartrate_option).to be true
    expect(activity.elev_high).to eq 462.0
    expect(activity.elev_low).to eq 174.2
    expect(activity.pr_count).to eq 0
    expect(activity.total_photo_count).to eq 1
    expect(activity.has_kudoed).to be false
    expect(activity.suffer_score).to eq 245.0
    expect(activity.calories).to eq 1824.0

    expect(activity.splits_metric).to be_a Enumerable
    split_metric = activity.splits_metric.first
    expect(split_metric).to be_a Strava::Models::Split
    expect(split_metric.distance).to eq 1009.1
    expect(split_metric.distance_in_meters).to eq 1009.1
    expect(split_metric.distance_in_miles).to eq 0.627024467
    expect(split_metric.elapsed_time).to eq 145
    expect(split_metric.pace_per_kilometer_s).to eq '2m24s/km'
    expect(split_metric.pace_per_mile_s).to eq '3m51s/mi'
    expect(split_metric.kilometer_per_hour_s).to eq '25.1km/h'
    expect(split_metric.miles_per_hour_s).to eq '15.6mph'
    expect(split_metric.elevation_difference).to eq 5.6
    expect(split_metric.total_elevation_gain).to eq 5.6
    expect(split_metric.total_elevation_gain_in_feet).to eq 18.372704
    expect(split_metric.total_elevation_gain_in_meters).to eq 5.6
    expect(split_metric.moving_time).to eq 145
    expect(split_metric.split).to eq 1
    expect(split_metric.average_speed).to eq 6.96
    expect(split_metric.average_heartrate).to eq 137.13793103448276
    expect(split_metric.pace_zone).to eq 0

    expect(activity.splits_standard).to be_a Enumerable
    split_standard = activity.splits_standard.first
    expect(split_standard).to be_a Strava::Models::Split
    expect(split_standard.distance).to eq 1617.2
    expect(split_standard.distance_in_meters).to eq 1617.2
    expect(split_standard.distance_in_miles).to eq 1.0048795640000001
    expect(split_standard.elapsed_time).to eq 215
    expect(split_standard.pace_per_kilometer_s).to eq '2m13s/km'
    expect(split_standard.pace_per_mile_s).to eq '3m34s/mi'
    expect(split_standard.kilometer_per_hour_s).to eq '27.1km/h'
    expect(split_standard.miles_per_hour_s).to eq '16.8mph'
    expect(split_standard.elevation_difference).to eq(-27.6)
    expect(split_standard.total_elevation_gain).to eq(-27.6)
    expect(split_standard.total_elevation_gain_in_feet).to eq(-90.551184)
    expect(split_standard.total_elevation_gain_in_meters).to eq(-27.6)
    expect(split_standard.moving_time).to eq 215
    expect(split_standard.split).to eq 1
    expect(split_standard.average_speed).to eq 7.52
    expect(split_standard.average_heartrate).to eq 132.16744186046512
    expect(split_standard.pace_zone).to eq 0

    expect(activity.laps).to be_a Enumerable
    lap = activity.laps.first
    expect(lap).to be_a Strava::Models::Lap
    expect(lap.id).to eq 12_991_952_135
    expect(lap.resource_state).to eq 2
    expect(lap.name).to eq 'Lap 1'
    expect(lap.activity).to be_a Strava::Models::Activity
    expect(lap.athlete).to be_a Strava::Models::Athlete
    expect(lap.elapsed_time).to eq 14_967
    expect(lap.moving_time).to eq 12_633
    expect(lap.start_date).to eq Time.new('2020', '8', '24', '7', '3', '53', '+00:00').utc
    expect(lap.start_date_local).to eq Time.new('2020', '8', '24', '9', '3', '53', '+02:00')
    expect(lap.distance).to eq 101_545.0
    expect(lap.start_index).to eq 0
    expect(lap.end_index).to eq 12_631
    expect(lap.total_elevation_gain).to eq 1021.5
    expect(lap.average_speed).to eq 8.04
    expect(lap.max_speed).to eq 20.5
    expect(lap.average_heartrate).to eq 144.8
    expect(lap.max_heartrate).to eq 175.0
    expect(lap.lap_index).to eq 1
    expect(lap.split).to eq 1
    expect(lap.pace_zone).to be nil

    gear = activity.gear
    expect(gear).to be_a Strava::Models::Gear
    expect(gear.id).to eq 'b6827635'
    expect(gear.resource_state).to eq 2
    expect(gear.name).to eq 'die Wattpeitsche'
    expect(gear.primary).to be false
    expect(gear.distance).to eq 5_560_929

    expect(activity.device_name).to eq 'Wahoo ELEMNT BOLT'

    expect(activity.segment_efforts).to be_a Enumerable
    segment_effort = activity.segment_efforts.first
    expect(segment_effort).to be_a Strava::Models::SegmentEffort
    expect(segment_effort.id).to eq 2_732_944_259_699_241_346
    expect(segment_effort.resource_state).to eq 2
    expect(segment_effort.name).to eq 'Spirkelbach Wilgartswiesen'
    expect(segment_effort.activity).to be_a Strava::Models::Activity
    expect(segment_effort.athlete).to be_a Strava::Models::Athlete
    expect(segment_effort.elapsed_time).to eq 142
    expect(segment_effort.moving_time).to eq 142
    expect(segment_effort.start_date).to eq Time.new('2020', '8', '24', '7', '4', '1', '+00:00').utc
    expect(segment_effort.start_date_local).to eq Time.new('2020', '8', '24', '9', '4', '1', '+02:00')
    expect(segment_effort.distance).to eq 1050.0
    expect(segment_effort.start_index).to eq 8
    expect(segment_effort.end_index).to eq 150
    expect(segment_effort.average_heartrate).to eq 138.5
    expect(segment_effort.max_heartrate).to eq 149

    segment = segment_effort.segment
    expect(segment).to be_a Strava::Models::Segment
    expect(segment.id).to eq 12_736_466
    expect(segment.resource_state).to eq 2
    expect(segment.name).to eq 'Spirkelbach Wilgartswiesen'
    expect(segment.distance).to eq 1050.0
    expect(segment.distance_s).to eq '1.05km'
    expect(segment.maximum_grade).to eq 6.3
    expect(segment.elevation_high).to eq 229.2
    expect(segment.elevation_low).to eq 216.2
    expect(segment.activity_type).to eq 'Ride'
    expect(segment.average_grade).to eq 0.4
    expect(segment.climb_category).to eq 0
    expect(segment.city).to eq 'Spirkelbach'
    expect(segment.state).to eq 'Rheinland-Pfalz'
    expect(segment.country).to eq 'Germany'
    expect(segment.start_latlng).to eq [49.198008, 7.883581]
    expect(segment.end_latlng).to eq [49.206226, 7.880881]
    expect(segment.start_latitude).to be nil
    expect(segment.start_longitude).to be nil
    expect(segment.end_latitude).to be nil
    expect(segment.end_longitude).to be nil
    expect(segment.private).to be false
    expect(segment.hazardous).to be false
    expect(segment.starred).to be false

    expect(segment_effort.achievements).to eq []
    expect(segment_effort.hidden).to be false
    expect(segment_effort.pr_rank).to be nil

    expect(activity.photos).to be_a Strava::Models::Photos
    photos = activity.photos
    expect(photos.use_primary_photo).to be false
    expect(photos.count).to eq 1
    photo = photos.primary
    expect(photo).to be_a Strava::Models::Photo
    expect(photo.id).to be nil
    expect(photo.unique_id).to eq 'F775717B-D1C1-443A-AD99-3D9A80FF11C9'
    expect(photo.urls).to eq(
      '100' => 'https://dgtzuqphqg23d.cloudfront.net/BO0H-YeNRZOfFhc0PctUheAKchsY2ll4vsagU58MNKg-128x96.jpg',
      '600' => 'https://dgtzuqphqg23d.cloudfront.net/BO0H-YeNRZOfFhc0PctUheAKchsY2ll4vsagU58MNKg-768x576.jpg'
    )
    expect(photo.source).to eq 1

    expect(activity.embed_token).to eq 'b5592179f6e7117b7d4e4084d5ebddd485ae72d6'

    expect(activity.available_zones).to eq %w[heartrate power]
  end
  it 'returns activity by id' do
    activity = client.activity(3_958_491_750)
    expect(activity).to be_a Strava::Models::Activity
    expect(activity.id).to eq 3_958_491_750
  end
end
