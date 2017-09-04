# frozen_string_literal: true

WriteState = Struct.new(:key, :database) do
  def perform(value)
    insert.call key: key, data: Sequel.pg_json(value)
  end

  private

  def insert
    @insert ||= database
                .states
                .insert_conflict(
                  target: :key, update: { data: Sequel[:excluded][:data] }
                )
                .prepare(:insert, :insert_state, key: :$key, data: :$data)
  end
end
