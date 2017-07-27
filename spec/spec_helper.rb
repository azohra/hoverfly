require 'pry'
require 'rspec'
require_relative '../lib/hoverfly'

RSpec.configure do |c|
  c.before(:context) do
    system('docker run -d -p 8888:8888 -p 8500:8500 --name hoverfly azohra/hoverfly')
    Hoverfly.set_ports(admin: 8888, proxy: 8500)
  end

  c.after(:context) do
    system('docker kill hoverfly')
    system('docker container rm hoverfly')
  end
end
