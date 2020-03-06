# frozen_string_literal: true

# Limits the Access to Internships for Users.
class UserCanSeeInternship < ApplicationRecord
  belongs_to :internship
  belongs_to :user
  validates :internship, presence: true
  validates :user, presence: true

  INTERNSHIP_LIMIT = 12

  def self.internship_search(internship_id:, user:)
    unless user.admin?
      internship = Internship.find(internship_id)
      return true unless where(internship: internship,
                               user: user).empty?
      return false unless check_limit(user: user)

      create(internship: internship, user: user)
    end
    true
  end

  def self.check_limit(user:)
    UserCanSeeInternship.where(user: user).count < INTERNSHIP_LIMIT
  end

  def self.user_associated_with_internship(user:, internship:)
    associated_internships(user: user).include? internship
  end

  def self.associated_internships(user:)
    return [] if (s = user.student).nil?

    s.internships
  end

  def self.associated_user_for_internship(internship:)
    internship.user
  end

  def self.number_of_viewed_internships_for_user(user:)
    UserCanSeeInternship.where(user: user).count
  end

  def self.limit
    INTERNSHIP_LIMIT
  end

  # denken ist wichtig
end
