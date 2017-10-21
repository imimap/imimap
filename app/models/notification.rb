# frozen_string_literal: true

# Notifications for Students.
class Notification < ActiveRecord::Base
  attr_accessible :read, :text, :link

  validates :text, presence: true

  belongs_to :user
end
