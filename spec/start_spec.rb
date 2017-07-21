require_relative 'spec_helper'

describe 'Hoverfly Control Gem' do
  after(:example) do
    Hoverfly.stop
  end

  it 'returns true when started successfully' do
    res = Hoverfly.start('test1')
    expect(res).to eq(true)
  end
end
