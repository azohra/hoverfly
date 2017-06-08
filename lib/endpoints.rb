module HoverflyAPI
  include HTTParty

  def get_current_simulations
    HoverflyAPI.get('/api/v2/simulation').response.body
  end

  def update_simulations(simulation)
    HoverflyAPI.put('/api/v2/simulation', headers: { 'Content-Type' => 'application/json' }, body: simulation).response.body
  end

  def get_current_simulation_schema
    HoverflyAPI.get('/api/v2/simulation/schema').response.body
  end

  def get_config_info
    HoverflyAPI.get('/api/v2/hoverfly').response.body
  end

  def get_current_destination
    HoverflyAPI.get(' /api/v2/hoverfly/destination').response.body
  end

  def update_destinitation(destination)
    HoverflyAPI.put(' /api/v2/hoverfly/destination', headers: { 'Content-Type' => 'application/json' }, body: { destination: destination }.to_json).response.body
  end

  def get_current_middleware
    HoverflyAPI.get('/api/v2/hoverfly/middleware').response.body
  end

  def update_middleware(middleware_request)
    HoverflyAPI.put('/api/v2/hoverfly/middleware', headers: { 'Content-Type' => 'application/json' }, body: middleware_request.to_json).response.body
  end

  def get_current_mode
    HoverflyAPI.get('/api/v2/hoverfly/mode').response.body
  end

  def update_mode(mode)
    HoverflyAPI.put('/api/v2/hoverfly/mode', headers: { 'Content-Type' => 'application/json' }, body: { mode: mode }.to_json).response.body
  end

  def get_usage
    HoverflyAPI.get('/api/v2/hoverfly/usage').response.body
  end

  def get_version
    HoverflyAPI.get('/api/v2/hoverfly/version').response.body
  end

  def get_upstream_proxy
    HoverflyAPI.get('/api/v2/hoverfly/upstream-proxy').response.body
  end

  def get_cached_data
    HoverflyAPI.get('/api/v2/cache').response.body
  end

  def clear_cached_data
    HoverflyAPI.delete('/api/v2/cache').response.body
  end

  def get_logs
    HoverflyAPI.get('/api/v2/logs').response.body
  end
end
