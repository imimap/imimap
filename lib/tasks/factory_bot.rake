# frozen_string_literal: true

# lib/tasks/factory_bot.rake
# see https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#linting-factories

namespace :factory_bot do
  desc 'Verify that all FactoryBot factories are valid'
  task lint: :environment do
    if Rails.env.test?
      DatabaseCleaner.cleaning do
        FactoryBot.lint
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")
      raise if $CHILD_STATUS.exitstatus.nonzero?
    end
  end
end
