# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'rspec'
require 'strava-ruby-client'

require 'multi_xml'
require 'gpx'
require 'polylines'

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].sort.each do |file|
  require file
end
