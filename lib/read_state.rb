# frozen_string_literal: true

ReadState = Struct.new(:key, :database) do
  def perform
    record = database.states.where(key: key).first
    return record[:data] if record
    {}
  end
end
