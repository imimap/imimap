# frozen_string_literal: true

# User for the activeadmin part. Deprecated. TBD: check if it can be deleted
class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  # validates :remember_me, presence: true
end
