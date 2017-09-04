
# frozen_string_literal: true

require './lib/database'
require './lib/read_state'

RSpec.describe ReadState do
  describe 'initialize' do
    it 'sets key, database' do
      key = :key
      read_state = ReadState.new(key, database)
      expect(read_state.key).to eq key
      expect(read_state.database).to eq database
    end
  end

  describe '#perform' do
    it 'returns the perform at `key`' do
      read_state = ReadState.new('VEND', database)

      expect(read_state.perform).to eq({})

      database.states << { key: 'VEND', data: Sequel.pg_json(foo: 1) }

      expect(read_state.perform).to eq('foo' => 1)
    end
  end
end
