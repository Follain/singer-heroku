# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :singer_states do
      String :key, primary_key: true
      jsonb :data
    end
  end
end
