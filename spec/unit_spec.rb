require_relative 'spec_helper'

describe 'Hoverfly Control Gem' do
  it "doesn\'t crap out with concurrency" do
    Hoverfly.start('test1')
    Hoverfly.import(['./spec/test_simulations/middleware.json'])
    rd, wr = IO.pipe
    Process.fork do
      rd.close
      Hoverfly.start('test2', {admin: 8887, proxy: 8499})
      Hoverfly.import(['./spec/test_simulations/test.json'])
      fork_response = `curl --proxy http://localhost:8499 http://test.com/test`
      wr.write fork_response
      wr.close
      Hoverfly.stop
    end
    wr.close
    Process.wait
    final_response = `curl --proxy http://localhost:8500 http://test.com`
    final_response << "\n&&\n" << rd.read
    expect(final_response).to eq("You have successfully hit the middleware\n&&\nYou have successfully imported this simulation")
    Hoverfly.stop
  end

  it 'successfully imports a simulation' do
    Hoverfly.start('test1')
    Hoverfly.import(['./spec/test_simulations/test.json'])
    expect(`curl --proxy 'http://localhost:8500' -X GET 'http://test.com/test'`).to eq('You have successfully imported this simulation')
    Hoverfly.stop
  end
  
  it 'successfully sets a middleware' do
    Hoverfly.start('test1')
    Hoverfly.import(['./spec/test_simulations/middleware.json'])
    rd, wr = IO.pipe
    Process.fork do
      rd.close
      Hoverfly.start('test2', {admin: 8887, proxy: 8499})
      Hoverfly.import(['./spec/test_simulations/test.json'])
      Hoverfly.middleware({remote: 'http:localhost:8500/test'})
      response = `curl --proxy http://localhost:8500 http://test.com`
      wr.write response
      wr.close
      Hoverfly.stop
    end
    wr.close
    Process.wait
    expect(rd.read).to eq('You have successfully hit the middleware')
    Hoverfly.stop
  end
  
end
