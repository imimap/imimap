# frozen_string_literal: true

module Abilities
  # defines abilities for admins
  class Admin
    include CanCan::Ability

    def initialize(_user)
      can :manage, :all
    end
  end
end
