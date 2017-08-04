# Hoverfly Gem
[![Build Status](https://travis-ci.org/azohra/hoverfly.svg?branch=master)](https://travis-ci.org/azohra/hoverfly)

Welcome to the Hoverfly Gem, a ruby written wrapper for Hoverfly!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hoverfly'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hoverfly

## Usage

This gem gives you full access to the Hoverfly API as well as the ability to dynamically build simulations to import into Hoverfly. See below for examples, as well as a reference of the actions that can be done.

This gem assumes that you have already started a running instance of Hoverfly. This can be done in multiple ways. For example, you can install Hoverfly on your host system and start it by executing:

    $ hoverctl start
    
Alternatively, you can start Hoverfly in a docker container and expose the Hoverfly admin and proxy ports to the host system as. If you have a docker image named `hoverfly` with Hoverfly already installed, then you can do this as follows:

    $ docker run -d -p 8888:8888 -p 8500:8500 --name hoverfly hoverfly

The following examples assume that you have already started a Hoverfly instance (docker or otherwise) with the default admin and proxy ports (8888 and 8500 respectively)

### Recording an API response
```ruby
require 'hoverfly'

# Specify the ports to be used to communicate with Hoverfly
Hoverfly.set_ports(admin: 8888, proxy: 8500)

# Set Hoverfly to capture mode
Hoverfly.update_mode('capture')

# Send the API request to be recorded
`curl --proxy http://localhost:8500 http://time.jsontest.com `

# Export the simulation that Hoverfly has recorded
file = File.open( "simulation.json", "w" )
file << Hoverfly.get_current_simulations
file.close
```
### Replaying an existing API response
```ruby
require 'hoverfly'

# Specify the ports to be used to communicate with Hoverfly
Hoverfly.set_ports(admin: 8888, proxy: 8500)

# Set Hoverfly to simulate mode
Hoverfly.update_mode('simulate')

# Import an existing simulation into Hoverfly
Hoverfly.import(['simulation.json'])

# Now when we make the API call, we will get the response that we imported into Hoverfly
`curl --proxy http://localhost:8500 http://time.jsontest.com`
```

### Available Methods
| Method | Description | Example |
|--------|-------------|---------|
|get_current_simulations|Returns the current simulation being used by Hoverfly|Hoverfly.get_current_simulations|
|get_current_simulation_schema|Returns the schema of the simulations currently being used by Hoverfly|Hoverfly.get_current_simulation_schema|
|import(file_list)|Compiles the given files into a simulation JSON file, and then sets that file as the simulation to be used by Hoverfly|Hoverfly.import(['./login.json', './logout.json'])|
|get_config_info|Returns Hoverfly configuration info|Hoverfly.get_config_info|
|get_current_destination|Returns the current destination that has been set for Hoverfly. Once a destination has been set, Hoverfly only intercepts traffic for that URL|Hoverfly.get_current_destination|
|update_destinitation|Sets / updates the destination URL that Hoverfly looks at|Hoverfly.update_destination('http://time.jsontest.com')|
|get_current_middleware|Returns info about the middleware that Hoverfly is currently set to use|Hoverfly.get_current_middleware|
|middleware|This allows you to set the middleware to be used by Hoverfly. This method accepts a hash where the key specifies the type of middleware, and the value specifies the location. For example if wanted to use a remote server for your middleware, you would pass {remote: <server_url>} to this method|Hoverfly.middleware({remote: 'http://mymiddleware.com'})|
|get_current_mode|Returns the mode that Hoverfly is currently set to|Hoverfly.get_current_mode|
|update_mode|Changes the mode that Hoverfly in running in. By default, Hoverfly starts in simulate mdoe|Hoverfly.update_mode('capture')|
|get_usage|Returns usage info for Hoverfly|Hoverfly.get_usage|
|get_version|Returns the current Hoverfly version|Hoverfly.get_version|
|get_upstream_proxy|Returns the proxy port that Hoverfly is currently using|Hoverfly.get_upstream_proxy|
|get_cached_data|Returns data that Hoverfly has cached|Hoverfly.get_cached_data|
|clear_cached_data|Clears the Hoverfly cache|Hoverfly.clear_cached_data|
|get_logs|Returns the Hoverfly logs|Hoverfly.get_logs|

## Contributing

Bug reports and pull requests are welcome. Note that if you are reporting a bug then make sure to include a failing spec that highlights an example of the bug. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
