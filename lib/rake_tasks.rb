# frozen_string_literal: true

require 'sequel'

module SingerHeroku
  # Rake tasks for migrating development database
  class RakeTasks
    include Rake::DSL if defined? Rake::DSL

    # rubocop:disable Rails/Output
    def install_tasks
      namespace :singer_heroku do
        desc 'Run migrations'
        task :migrate, [:version] do |_t, args|
          Sequel.extension :migration
          db = Sequel.connect(ENV.fetch('DATABASE_URL'))
          version = args[:version]
          puts "Migrating to #{version || 'latest'}"
          version = version&.to_i
          Sequel::Migrator.run(db, 'db/migrations', target: version)
        end
      end
    end
  end
end

SingerHeroku::RakeTasks.new.install_tasks
