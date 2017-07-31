describe 'The Hoverfly API', order: :defined do
  context 'Modes' do
    it 'Can update the mode' do
      expect(Hoverfly.update_mode('modify')).to eql('{"mode":"modify","arguments":{}}')
    end

    it 'Returns the current mode' do
      expect(Hoverfly.get_current_mode).to eql('{"mode":"modify","arguments":{}}')
    end
  end
end
