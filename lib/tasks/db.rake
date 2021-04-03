# frozen_string_literal: true

namespace :db do
  desc 'empty and re-seed database'
  task reseed: :environment do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.start
    DatabaseCleaner.clean
    Rake::Task['db:seed'].execute
  end
  desc 'add test students to existing db'
  task addSome: :environment do
    # load '../../db/seed/08_lib/08_create_students.rb'
    load 'db/seed/08_lib/08_create_students.rb'
  end
end
