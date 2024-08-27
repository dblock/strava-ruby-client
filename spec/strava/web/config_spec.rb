# frozen_string_literal: true

require 'spec_helper'

describe Strava::Web::Config do
  describe '#configure' do
    before do
      Strava::Web.configure do |config|
        config.ca_file = OpenSSL::X509::DEFAULT_CERT_FILE
        config.ca_path = OpenSSL::X509::DEFAULT_CERT_DIR
      end
    end

    it 'sets SSL certificates' do
      expect(Strava::Web.config.ca_file).to eq OpenSSL::X509::DEFAULT_CERT_FILE
      expect(Strava::Web.config.ca_path).to eq OpenSSL::X509::DEFAULT_CERT_DIR
    end
  end
end
