# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'rspec'
require 'strava-ruby-client'

require 'tempfile'
require 'multi_xml'
require 'gpx'
require 'tcxread'
require 'polylines'

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].each do |file|
  require file
end
