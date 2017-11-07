# frozen_string_literal: true

# Active Record Models Now Inherit from ApplicationRecord by Default
# (since Rails 5.0)
# http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#upgrading-from-rails-4-2-to-rails-5-0
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
