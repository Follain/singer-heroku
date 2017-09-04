# frozen_string_literal: true

require 'json'

GenerateConfig = Struct.new(:env, :key) do
  def key_pattern
    /^#{key}_CONFIG_(.+)/
  end

  def to_json
    JSON.generate(values)
  end

  def values
    Hash[
      env.keys.grep(key_pattern).map do |key|
        [
          key.match(key_pattern)[1],
          env[key]
        ]
      end
    ]
  end
end
