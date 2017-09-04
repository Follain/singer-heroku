
# frozen_string_literal: true

require './lib/database'
require './lib/write_state'

RSpec.describe WriteState do
  describe 'initialize' do
    it 'sets key, database' do
      key = :key
      write_state = WriteState.new(key, database)
      expect(write_state.key).to eq key
      expect(write_state.database).to eq database
    end
  end

  describe '#perform' do
    it 'upserts data into the database' do
      write_state = WriteState.new('VEND', database)
      returned = write_state.perform(foo: { bar: 1 })
      expect(returned).to eq 'VEND'

      expect(database.states.count).to eq 1
      record = database.states.first
      expect(record.keys).to match_array %i[key data]
      expect(record[:key]).to eq 'VEND'
      expect(record[:data]).to eq 'foo' => { 'bar' => 1 }

      returned = write_state.perform(foo: { baz: 2 })
      expect(returned).to eq 'VEND'

      expect(database.states.count).to eq 1
      record = database.states.first
      expect(record.keys).to match_array %i[key data]
      expect(record[:key]).to eq 'VEND'
      expect(record[:data]).to eq 'foo' => { 'baz' => 2 }
    end
  end
end
