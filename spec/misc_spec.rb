describe 'The Hoverfly API' do
  context 'Misc Info' do
    it 'Returns the middleware being used' do
      expect(Hoverfly.get_current_middleware).to eql('{"binary":"","script":"","remote":""}')
    end

    it 'Returns the config info' do
      expect(Hoverfly.get_config_info).to eql(File.read('./spec/support/expected_responses/config_response'))
    end

    it 'Returns usage stats' do
      expect(Hoverfly.get_usage).to eql('{"usage":{"counters":{"capture":0,"modify":0,"simulate":0,"synthesize":0}}}')
    end

    it 'Returns the version' do
      expect(Hoverfly.get_version).to eql('{"version":"v0.13.0"}')
    end

    it 'Returns the upstream proxy' do
      expect(Hoverfly.get_upstream_proxy).to eql('{"upstream-proxy":""}')
    end

    it 'Returns the logs' do
      expect(Hoverfly.get_logs).to match(File.read('./spec/support/expected_responses/logs_response'))
    end
  end
end
