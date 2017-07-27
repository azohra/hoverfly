describe 'Hoverfly Control Gem' do
  context 'used as a webserver' do
    it 'successfully imports a simulation' do
      Hoverfly.import(['./spec/support/test_simulations/test.json'])
      expect(`curl -X GET 'http://localhost:8500/test'`).to eq('You have successfully imported this simulation')
    end

    it 'successfully sets a middleware' do
      Hoverfly.import(['./spec/support/test_simulations/middleware.json'])
      rd, wr = IO.pipe
      Process.fork do
        rd.close
        system('docker run -d -p 8887:8888 -p 8499:8500 --link hoverfly:hoverfly  --name hoverfly_2 azohra/hoverfly')
        Hoverfly.set_ports(admin: 8887, proxy: 8499)
        Hoverfly.import(['./spec/support/test_simulations/test.json'])
        Hoverfly.middleware(remote: 'http://172.17.0.2:8500/middleware')
        response = `curl http://localhost:8499/test`
        wr.write response
        wr.close
        system('docker kill hoverfly_2')
        system('docker container rm hoverfly_2')
      end
      wr.close
      Process.wait
      expect(rd.read).to eq('You have successfully hit the middleware')
    end
  end
end
