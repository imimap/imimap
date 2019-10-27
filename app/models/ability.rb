# frozen_string_literal: true

# https://github.com/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability
  def initialize(user)
    return unless user.present?

    merge Abilities::User.new(user)

    return unless user.prof? || user.examination_office? || user.admin?

    merge Abilities::Staff.new(user)
    return unless user.admin?

    can :manage, :all
  end
end
