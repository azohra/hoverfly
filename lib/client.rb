class Hoverfly
  extend HoverflyAPI

  class << self
    attr_reader :admin_port, :proxy_port

    def set_ports(admin:, proxy:, ip: 'localhost')
      @admin_port = admin
      @proxy_port = proxy
      HoverflyAPI.default_options.update(verify: false)
      HoverflyAPI.format :json
      HoverflyAPI.base_uri "http://#{ip}:#{@admin_port}"
    end

    def middleware(middleware_location)
      update_middleware({ binary: '', script: '', remote: '' }.merge(middleware_location))
    end

    def import(file_list, meta = {})
      update_simulations(to_simulation(file_list, meta))
    end

    private

    def to_simulation(file_list, meta)
      schema_path = meta[:schema] || File.expand_path('schema_metadata/schema.json.erb', __dir__)
      all_simulations = file_list.map { |filename| File.read(filename) }
      erb(File.read(schema_path)) { all_simulations.join(',') }
    end

    def erb(template)
      ERB.new(template).result(binding)
    end
  end
end
