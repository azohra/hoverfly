describe 'The Hoverfly API' do
  context 'Simulations' do
    it 'Returns the current simulation' do
      expect(Hoverfly.get_current_simulations).to match('{"data":{"pairs":\\[\\],"globalActions":{"delays":\\[\\]}},"meta":{"schemaVersion":"v3","hoverflyVersion":"v0.13.0","timeExported":".*"}}')
    end

    it 'Returns the simulation schema' do
      expect(Hoverfly.get_current_simulation_schema).to eql(File.read('./spec/support/expected_responses/simulation_response'))
    end
  end
end
