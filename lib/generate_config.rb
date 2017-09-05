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
          cast_if_needed(env[key])
        ]
      end
    ]
  end

  private

  def cast_if_needed(value)
    return value.to_i if value.to_i.to_s == value
    return value.to_f if value.to_f.to_s == value

    value
  end
end
