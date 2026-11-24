# frozen_string_literal: true

require 'spec_helper'
require 'open3'
require 'tmpdir'

describe 'bin/strava-webhooks' do
  let(:script) { File.expand_path('../../bin/strava-webhooks', __dir__) }

  def run_with_response(status, body, method: :post, url: 'https://www.strava.com/api/v3/push_subscriptions', args: ['create', 'https://example.com/'])
    Dir.mktmpdir do |dir|
      stub = File.join(dir, 'stub.rb')
      File.write(stub, <<~RUBY)
        require 'webmock'
        include WebMock::API
        WebMock.enable!
        stub_request(:#{method}, %r{\\A#{Regexp.escape(url)}}).to_return(
          status: #{status}, headers: { 'Content-Type' => 'application/json' }, body: #{body.to_json.inspect}
        )
      RUBY
      env = { 'STRAVA_CLIENT_ID' => 'client-id', 'STRAVA_CLIENT_SECRET' => 'client-secret', 'RUBYOPT' => "#{ENV.fetch('RUBYOPT', nil)} -r#{stub}" }
      Open3.capture3(env, Gem.ruby, script, *args, chdir: dir)
    end
  end

  it 'displays the reason a request failed' do
    _, stderr, status = run_with_response(400, { message: 'Bad Request', errors: [{ resource: 'PushSubscription', field: '', code: 'already exists' }] })
    expect(stderr).to include('Bad Request: PushSubscription already exists.')
    expect(stderr).not_to include('Strava::Errors::Fault')
    expect(status.exitstatus).to eq 1
  end

  it 'displays the reason a resource was not found without the client secret' do
    _, stderr, status = run_with_response(
      404, { message: 'Resource Not Found', errors: [{ resource: 'PushSubscription', field: '', code: 'not found' }] },
      method: :delete, url: 'https://www.strava.com/api/v3/push_subscriptions/123', args: %w[delete 123]
    )
    expect(stderr).to include('Resource Not Found: PushSubscription not found.')
    expect(stderr).not_to include('client-secret')
    expect(status.exitstatus).to eq 1
  end

  it 'displays the message without errors' do
    _, stderr, status = run_with_response(403, { message: 'Authorization Error' })
    expect(stderr).to include('Authorization Error.')
    expect(status.exitstatus).to eq 1
  end

  describe 'handle' do
    let(:port) { TCPServer.open('127.0.0.1', 0) { |s| s.addr[1] } }
    let(:payload) do
      '{"aspect_type":"update","event_time":1795556654,"object_id":21096098721,"object_id_str":"21096098721",' \
        '"object_type":"activity","owner_id":26462176,"owner_id_str":"26462176","subscription_id":390723,' \
        '"updates":{"title":"Run"}}'
    end

    # Waits for the server to start, which takes several seconds on JRuby.
    def post_event(port, payload, timeout: 60)
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
      begin
        Net::HTTP.post(URI("http://127.0.0.1:#{port}/"), payload, 'Content-Type' => 'application/json')
      rescue Errno::ECONNREFUSED, Errno::ECONNRESET
        raise 'strava-webhooks handle did not start.' if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline

        sleep 0.2
        retry
      end
    end

    it 'logs the event and its raw JSON' do
      VCR.turn_off!
      WebMock.allow_net_connect!
      env = { 'STRAVA_CLIENT_ID' => 'client-id', 'STRAVA_CLIENT_SECRET' => 'client-secret', 'PORT' => port.to_s }
      Open3.popen3(env, Gem.ruby, script, 'handle') do |_stdin, _stdout, stderr, thread|
        response = post_event(port, payload)
        expect(response.body).to eq '{"ok":true}'
        Process.kill('INT', thread.pid)
        log = stderr.read
        expect(log).to include('id_str="21096098721"', 'owner_id_str="26462176"')
        expect(log).to include(payload)
      end
    ensure
      WebMock.disable_net_connect!
      VCR.turn_on!
    end
  end
end
