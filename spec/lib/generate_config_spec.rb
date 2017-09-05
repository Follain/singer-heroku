
# frozen_string_literal: true

require './lib/generate_config'

RSpec.describe GenerateConfig do
  describe 'initialize' do
    it 'sets env, key' do
      env = { foo: :bar }
      key = :key

      config = GenerateConfig.new(env, key)
      expect(config.env).to eq env
      expect(config.key).to eq key
    end

    describe 'to_json' do
      let(:env) do
        {
          'VEND_CONFIG_username' => 'user',
          'VEND_CONFIG_password' => 'password',
          'VEND_CONFIG_integer' => '1',
          'VEND_CONFIG_float' => '1.01',
          'VEND_OTHER' => 'other',
          'OTHER_CONFIG_USERNAME' => 'other_user'
        }
      end

      let(:key) { 'VEND' }
      subject(:json) { GenerateConfig.new(env, key).to_json }

      it { is_expected.to be_a String }

      it 'is a JSON hash of the correct key, value pairs' do
        hash = JSON.parse(json)

        expect(hash).to eq(
          'password' => 'password',
          'username' => 'user',
          'integer' => 1,
          'float' => 1.01
        )
      end
    end
  end
end
