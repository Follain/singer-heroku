# frozen_string_literal: true

RSpec.shared_context 'Global Helpers' do
  let(:database) do
    Database.new(ENV.fetch('DATABASE_URL'))
  end
end

RSpec.configure do |config|
  config.include_context 'Global Helpers'

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    require 'dotenv'
    Dotenv.load '.env.test'

    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch('DATABASE_URL'))
    Sequel::Migrator.check_current(db, 'db/migrations')
  end

  config.around(:each) do |example|
    database.db.transaction(rollback: :always, auto_savepoint: true) do
      example.run
    end
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
