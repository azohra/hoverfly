describe 'The Hoverfly API' do
  context 'Cache' do
    it 'Clears the cache' do
      expect(Hoverfly.clear_cached_data).to eql('{"cache":null}')
    end

    it 'Returns data stored in cache' do
      expect(Hoverfly.get_cached_data).to eql('{"cache":null}')
    end
  end
end
