module Strava
  module Api
    module Endpoints
      module Segments
        #
        # Returns the top 10 segments matching a specified query.
        #
        # @option options [Array[Float]] :bounds
        #   The latitude and longitude for two points describing a rectangular boundary for the search: [southwest corner latitude, southwest corner longitude, northeast corner latitude, northeast corner longitude].
        # @option options [String] :activity_type
        #   Desired activity type. May take one of the following values: running, riding.
        # @option options [Integer] :min_cat
        #   The minimum climbing category.
        # @option options [Integer] :max_cat
        #   The maximum climbing category.
        #
        def explore_segments(options = {})
          throw ArgumentError.new('Required argument :bounds missing') if options[:bounds].nil?
          bounds = options[:bounds]
          bounds = bounds.map(&:to_s).join(',') if bounds.is_a?(Array)
          get('segments/explore', options.merge(bounds: bounds))['segments'].map do |row|
            Strava::Models::ExplorerSegment.new(row)
          end
        end

        #
        # Returns the specified segment leaderboard.
        #
        # @option options [Integer] :id
        #   The identifier of the segment leaderboard.
        # @option options [String] :gender
        #   Filter by gender.
        # @option options [String] :age_group
        #   Filter by age group.
        # @option options [String] :weight_class
        #   Filter by weight class.
        # @option options [Boolean] :following
        #   Filter by friends of the authenticated athlete.
        # @option options [Integer] :club_id
        #   Filter by club.
        # @option options [String] :date_range
        #   Filter by date range.
        # @option options [Integer] :context_entries
        #   ?
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def segment_leaderboard(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?

          if block_given?
            next_page = 1
            total_count = 0
            loop do
              query = options.merge(page: next_page).except(:id)
              response = Strava::Models::SegmentLeaderboard.new(get("segments/#{options[:id]}/leaderboard", query))
              total_count += response.entries.count
              break unless response.entries.any?

              yield response
              break if total_count >= response.entry_count

              next_page += 1
            end
          else
            Strava::Models::SegmentLeaderboard.new(get("segments/#{options[:id]}/leaderboard", options.except(:id)))
          end
        end

        #
        # List of the authenticated athlete's starred segments.
        #
        # @option options [Integer] :page
        #   Page number.
        # @option options [Integer] :per_page
        #   Number of items per page. Defaults to 30.
        #
        def starred_segments(options = {}, &block)
          paginate 'segments/starred', options, Strava::Models::Segment, &block
        end

        #
        # Returns the specified segment.
        #
        # @option options [String] :id
        #   The identifier of the segment.
        #
        def segment(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          Strava::Models::Segment.new(get("segments/#{options[:id]}", options.except(:id)))
        end

        #
        # Stars/Unstars the given segment for the authenticated athlete.
        #
        # @option options [String] :id
        #   The identifier of the segment to star.
        # @option options [Boolean] :starred
        #   If true, star the segment; if false, unstar the segment.
        #
        def star_segment(options = {})
          throw ArgumentError.new('Required argument :id missing') if options[:id].nil?
          throw ArgumentError.new('Required argument :starred missing') if options[:starred].nil?
          Strava::Models::Segment.new(put("segments/#{options[:id]}/starred", options.except(:id)))
        end
      end
    end
  end
end
