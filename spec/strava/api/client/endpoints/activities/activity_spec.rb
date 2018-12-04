require 'spec_helper'

RSpec.describe 'Strava::Api::Client#activity', vcr: { cassette_name: 'client/activity' } do
  let(:client) { Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'] || 'access-token') }
  it 'returns activity' do
    activity = client.activity(id: 1_946_417_534)

    expect(activity).to be_a Strava::Models::Activity
    expect(activity.id).to eq 1_946_417_534
    expect(activity.resource_state).to eq 3
    expect(activity.athlete).to be_a Strava::Models::Athlete
    expect(activity.athlete.id).to eq 26_462_176
    expect(activity.athlete.resource_state).to eq 1
    expect(activity.name).to eq 'TCS NYC Marathon 2018'
    expect(activity.description).to eq "Official time 3:42:02. Race got impossibly hard at mile 21 but I never stopped except to pee on mile 9. \r\n\r\nI am so fucking happy that I did this!"

    expect(activity.distance).to eq 42_268.1
    expect(activity.distance_in_miles).to eq 26.264129297
    expect(activity.distance_in_miles_s).to eq '26.26mi'
    expect(activity.distance_in_yards).to eq 46_224.816841
    expect(activity.distance_in_yards_s).to eq '46224.8yd'
    expect(activity.distance_in_meters).to eq 42_268.1
    expect(activity.distance_in_meters_s).to eq '42268m'
    expect(activity.distance_in_kilometers).to eq 42.2681
    expect(activity.distance_in_kilometers_s).to eq '42.27km'
    expect(activity.distance_s).to eq '42.27km'

    expect(activity.moving_time).to eq 13_085
    expect(activity.elapsed_time).to eq 13_333
    expect(activity.moving_time_in_hours_s).to eq '3h38m5s'
    expect(activity.elapsed_time_in_hours_s).to eq '3h42m13s'
    expect(activity.pace_per_mile_s).to eq '8m28s/mi'
    expect(activity.pace_per_100_yards_s).to eq '0m29s/100yd'
    expect(activity.pace_per_100_meters_s).to eq '0m32s/100m'
    expect(activity.pace_per_kilometer_s).to eq '5m15s/km'
    expect(activity.pace_s).to eq '5m15s/km'
    expect(activity.kilometer_per_hour_s).to eq '11.4km/h'
    expect(activity.miles_per_hour_s).to eq '7.1mph'
    expect(activity.speed_s).to eq '11.4km/h'

    expect(activity.total_elevation_gain).to eq 270.9
    expect(activity.total_elevation_gain_in_feet).to eq 888.779556
    expect(activity.total_elevation_gain_in_meters).to eq 270.9
    expect(activity.total_elevation_gain_in_meters_s).to eq '270.9m'
    expect(activity.total_elevation_gain_in_feet_s).to eq '888.8ft'
    expect(activity.total_elevation_gain_s).to eq '270.9m'

    expect(activity.type).to eq 'Run'
    expect(activity.workout_type).to eq 1
    expect(activity.external_id).to eq '17900304917.tcx'
    expect(activity.upload_id).to eq 2_082_412_856
    expect(activity.start_date).to eq Time.new(2018, 11, 0o4, 14, 53, 46, '-00:00').utc
    expect(activity.start_date_local).to eq Time.new(2018, 11, 4, 9, 53, 46, '-00:00').utc
    expect(activity.timezone).to eq '(GMT-05:00) America/New_York'
    expect(activity.utc_offset).to eq(-18_000.0)
    expect(activity.start_latlng).to eq [40.6, -74.06]
    expect(activity.end_latlng).to eq [40.77, -73.98]
    expect(activity.location_city).to be nil
    expect(activity.location_state).to be nil
    expect(activity.location_country).to eq ''
    expect(activity.start_latitude).to eq 40.6
    expect(activity.start_longitude).to eq(-74.06)
    expect(activity.achievement_count).to eq 7
    expect(activity.kudos_count).to eq 33
    expect(activity.comment_count).to eq 8
    expect(activity.athlete_count).to eq 301
    expect(activity.photo_count).to eq 0
    expect(activity.map).to be_a Strava::Models::Map
    expect(activity.map.id).to eq 'a1946417534'
    expect(activity.map.resource_state).to eq 3
    expect(activity.trainer).to be false
    expect(activity.commute).to be false
    expect(activity.manual).to be false
    expect(activity.private).to be false
    expect(activity.visibility).to eq 'everyone'
    expect(activity.flagged).to be false
    expect(activity.gear_id).to eq 'g3423618'
    expect(activity.from_accepted_tag).to be false
    expect(activity.average_speed).to eq 3.17
    expect(activity.max_speed).to eq 5.6
    expect(activity.has_heartrate).to be true
    expect(activity.average_heartrate).to eq 170.1
    expect(activity.max_heartrate).to eq 187.0
    expect(activity.heartrate_opt_out).to be false
    expect(activity.display_hide_heartrate_option).to be false
    expect(activity.elev_high).to eq 54.7
    expect(activity.elev_low).to eq(-8.1)
    expect(activity.pr_count).to eq 0
    expect(activity.total_photo_count).to eq 9
    expect(activity.has_kudoed).to be false
    expect(activity.suffer_score).to eq 656
    expect(activity.calories).to eq 3760.0

    expect(activity.splits_metric).to be_a Enumerable
    split_metric = activity.splits_metric.first
    expect(split_metric).to be_a Strava::Models::Split
    expect(split_metric.distance).to eq 1001.6
    expect(split_metric.distance_in_meters).to eq 1001.6
    expect(split_metric.distance_in_miles).to eq 0.622364192
    expect(split_metric.elapsed_time).to eq 314
    expect(split_metric.pace_per_kilometer_s).to eq '5m13s/km'
    expect(split_metric.pace_per_mile_s).to eq '8m24s/mi'
    expect(split_metric.kilometer_per_hour_s).to eq '11.5km/h'
    expect(split_metric.miles_per_hour_s).to eq '7.1mph'
    expect(split_metric.elevation_difference).to eq 15.6
    expect(split_metric.total_elevation_gain).to eq 15.6
    expect(split_metric.total_elevation_gain_in_feet).to eq 51.181104
    expect(split_metric.total_elevation_gain_in_meters).to eq 15.6
    expect(split_metric.moving_time).to eq 314
    expect(split_metric.split).to eq 1
    expect(split_metric.average_speed).to eq 3.19
    expect(split_metric.average_heartrate).to eq 157.96178343949043
    expect(split_metric.pace_zone).to eq 2

    expect(activity.splits_standard).to be_a Enumerable
    split_standard = activity.splits_standard.first
    expect(split_standard).to be_a Strava::Models::Split
    expect(split_standard.distance).to eq 1609.9
    expect(split_standard.distance_in_meters).to eq 490.69750429767987
    expect(split_standard.distance_in_miles).to eq 0.30490530303030305
    expect(split_standard.elapsed_time).to eq 489
    expect(split_standard.pace_per_kilometer_s).to eq '5m04s/km'
    expect(split_standard.pace_per_mile_s).to eq '8m09s/mi'
    expect(split_standard.kilometer_per_hour_s).to eq '11.8km/h'
    expect(split_standard.miles_per_hour_s).to eq '7.4mph'
    expect(split_standard.elevation_difference).to eq 5.9
    expect(split_standard.total_elevation_gain).to eq 5.9
    expect(split_standard.total_elevation_gain_in_feet).to eq 5.9
    expect(split_standard.total_elevation_gain_in_meters).to eq 1.798319942453762
    expect(split_standard.moving_time).to eq 489
    expect(split_standard.split).to eq 1
    expect(split_standard.average_speed).to eq 3.29
    expect(split_standard.average_heartrate).to eq 161.37832310838445
    expect(split_standard.pace_zone).to eq 2

    expect(activity.laps).to be_a Enumerable
    lap = activity.laps.first
    expect(lap).to be_a Strava::Models::Lap
    expect(lap.id).to eq 6_270_116_916
    expect(lap.resource_state).to eq 2
    expect(lap.name).to eq 'Lap 1'
    expect(lap.activity).to be_a Strava::Models::Activity
    expect(lap.athlete).to be_a Strava::Models::Athlete
    expect(lap.elapsed_time).to eq 13_306
    expect(lap.moving_time).to eq 13_299
    expect(lap.start_date).to eq Time.new(2018, 11, 0o4, 14, 53, 46, '-00:00').utc
    expect(lap.start_date_local).to eq Time.new(2018, 11, 4, 9, 53, 46, '-00:00').utc
    expect(lap.distance).to eq 42_882.9
    expect(lap.start_index).to eq 0
    expect(lap.end_index).to eq 13_128
    expect(lap.total_elevation_gain).to eq 270.9
    expect(lap.average_speed).to eq 3.22
    expect(lap.max_speed).to eq 5.6
    expect(lap.average_heartrate).to eq 170.1
    expect(lap.max_heartrate).to eq 187.0
    expect(lap.lap_index).to eq 1
    expect(lap.split).to eq 1
    expect(lap.pace_zone).to eq 2

    gear = activity.gear
    expect(gear).to be_a Strava::Models::Gear
    expect(gear.id).to eq 'g3423618'
    expect(gear.resource_state).to eq 2
    expect(gear.name).to eq 'adidas Supernova ST'
    expect(gear.primary).to be true
    expect(gear.distance).to eq 366_945.0

    expect(activity.device_name).to eq 'Fitbit Ionic'

    expect(activity.segment_efforts).to be_a Enumerable
    segment_effort = activity.segment_efforts.first
    expect(segment_effort).to be_a Strava::Models::SegmentEffort
    expect(segment_effort.id).to eq 49_065_850_796
    expect(segment_effort.resource_state).to eq 2
    expect(segment_effort.name).to eq 'NYC Marathon Mile 1'
    expect(segment_effort.activity).to be_a Strava::Models::Activity
    expect(segment_effort.athlete).to be_a Strava::Models::Athlete
    expect(segment_effort.elapsed_time).to eq 461
    expect(segment_effort.moving_time).to eq 461
    expect(segment_effort.start_date).to eq Time.new(2018, 11, 0o4, 14, 53, 46, '-00:00').utc
    expect(segment_effort.start_date_local).to eq Time.new(2018, 11, 4, 9, 53, 46, '-00:00').utc
    expect(segment_effort.distance).to eq 1499.5
    expect(segment_effort.start_index).to eq 0
    expect(segment_effort.end_index).to eq 462
    expect(segment_effort.average_heartrate).to eq 161.1
    expect(segment_effort.max_heartrate).to eq 169.0

    segment = segment_effort.segment
    expect(segment).to be_a Strava::Models::Segment
    expect(segment.id).to eq 8_457_023
    expect(segment.resource_state).to eq 2
    expect(segment.name).to eq 'NYC Marathon Mile 1'
    expect(segment.distance).to eq 1558.7
    expect(segment.distance_s).to eq '1.56km'
    expect(segment.maximum_grade).to eq 8.2
    expect(segment.elevation_high).to eq 34.9
    expect(segment.elevation_low).to eq(-0.4)
    expect(segment.activity_type).to eq 'Run'
    expect(segment.average_grade).to eq(-2.1)
    expect(segment.climb_category).to eq 0
    expect(segment.city).to eq 'Staten Island'
    expect(segment.state).to eq 'New York'
    expect(segment.country).to eq 'United States'
    expect(segment.start_latlng).to eq [40.601918, -74.06061]
    expect(segment.end_latlng).to eq [40.607072, -74.043591]
    expect(segment.start_latitude).to eq 40.601918
    expect(segment.start_longitude).to eq(-74.06061)
    expect(segment.end_latitude).to eq 40.607072
    expect(segment.end_longitude).to eq(-74.043591)
    expect(segment.private).to be false
    expect(segment.hazardous).to be false
    expect(segment.starred).to be false

    expect(segment_effort.achievements).to eq []
    expect(segment_effort.hidden).to be false
    expect(segment_effort.pr_rank).to eq nil

    expect(activity.best_efforts).to be_a Enumerable
    best_effort = activity.best_efforts.first
    expect(best_effort).to be_a Strava::Models::SegmentEffort
    expect(best_effort.id).to eq 4_155_301_967

    expect(activity.photos).to be_a Strava::Models::Photos
    photos = activity.photos
    expect(photos.use_primary_photo).to be true
    expect(photos.count).to eq 9
    photo = photos.primary
    expect(photo).to be_a Strava::Models::Photo
    expect(photo.id).to be nil
    expect(photo.unique_id).to eq '5e8006d0-8349-40ad-a4ef-72b5e6e82dfe'
    expect(photo.urls).to eq(
      '100' => 'https://dgtzuqphqg23d.cloudfront.net/mo8thQ4Z5qAylUaRZHOWAR1sp16Bo-pp0ggYQKSWiZE-90x128.jpg',
      '600' => 'https://dgtzuqphqg23d.cloudfront.net/mo8thQ4Z5qAylUaRZHOWAR1sp16Bo-pp0ggYQKSWiZE-540x768.jpg'
    )
    expect(photo.source).to eq 1

    expect(activity.embed_token).to eq '6f5179ffed45a82d3e12d324fdc2814bd422d1da'

    similar_activities = activity.similar_activities
    expect(similar_activities).to be_a Strava::Models::SimilarActivities
    expect(similar_activities.average_speed).to eq 3.2302713030187236
    expect(similar_activities.resource_state).to eq 2
    expect(similar_activities.effort_count).to eq 1
    expect(similar_activities.frequency_milestone).to be nil
    expect(similar_activities.max_average_speed).to eq 3.2302713030187236
    expect(similar_activities.mid_average_speed).to eq 3.2302713030187236
    expect(similar_activities.min_average_speed).to eq 3.2302713030187236
    expect(similar_activities.mid_speed).to be nil
    expect(similar_activities.min_speed).to be nil
    expect(similar_activities.speeds).to be nil

    trend = similar_activities.trend
    expect(trend).to be_a Strava::Models::Trend
    expect(trend.speeds).to eq [3.2302713030187236]
    expect(trend.current_activity_index).to eq 0
    expect(trend.min_speed).to eq 3.2302713030187236
    expect(trend.mid_speed).to eq 3.2302713030187236
    expect(trend.max_speed).to eq 3.2302713030187236
    expect(trend.direction).to eq 0

    expect(activity.available_zones).to eq %w[heartrate pace]
  end
  it 'returns activity by id' do
    activity = client.activity(1_946_417_534)
    expect(activity).to be_a Strava::Models::Activity
    expect(activity.id).to eq 1_946_417_534
  end
end
