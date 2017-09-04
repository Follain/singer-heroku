
# frozen_string_literal: true

require 'sequel'

Database = Struct.new(:url) do
  def db
    @db ||= Sequel.connect(url).tap do |db|
      db.extension :pg_json
    end
  end

  def states
    db[:singer_states]
  end

  def logger=(logger)
    db.loggers = [logger]
  end
end
