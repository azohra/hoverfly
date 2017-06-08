class Hoverfly
  extend HoverflyAPI

  class << self
    attr_reader :target

    def start(target, ports = {})
      @target = target
      admin_port = ports.fetch(:admin, 8888)
      proxy_port = ports.fetch(:proxy, 8500)
      puts "Starting target #{target} with admin #{admin_port} and proxy #{proxy_port}"
      system "hoverctl targets create #{@target}"
      system "hoverctl start --admin-port #{admin_port} --proxy-port #{proxy_port} -t #{@target}"
      HoverflyAPI.default_options.update(verify: false)
      HoverflyAPI.format :json
      HoverflyAPI.base_uri "http://localhost:#{admin_port}"
    end

    def stop
      puts "Stopping target #{Hoverfly.target} with base URL #{HoverflyAPI.base_uri}"
      system "hoverctl stop -t #{@target}"
      system "hoverctl targets delete #{@target} -f"
    end

    def middleware(middleware_location)
      update_middleware({binary: '', script: '', remote: ''}.merge(middleware_location))
    end

    def import(file_list)
      update_simulations(to_simulation(file_list))
    end

    private

    def to_simulation(file_list, meta = {})
      header_path = meta[:header] || File.expand_path('schema_metadata/header.json', __dir__)
      footer_path = meta[:footer] || File.expand_path('schema_metadata/footer.json', __dir__)
      header = File.open(header_path)
      footer = File.open(footer_path)
      mock = header.read
      all_simulations = file_list.map do |filename| 
        file = File.open(filename)
        simulation = file.read
        file.close
        simulation
      end
      mock << all_simulations.join(',')
      mock << footer.read
      header.close
      footer.close
      mock
    end
  end
end
