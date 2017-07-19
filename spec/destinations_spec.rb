require_relative 'spec_helper'

describe 'The Hoverfly API' do
  context 'Destinations' do
    it 'Can update the destination' do
      expect(Hoverfly.update_destination('/test')).to eql('{"destination":"/test"}')
    end

    it 'Returns the current destination' do
      expect(Hoverfly.get_current_destination).to eql('{"destination":"/test"}')
    end
  end
end
