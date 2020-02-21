# frozen_string_literal: true

module Abilities
  # defines abilities for staff members
  class Staff
    include CanCan::Ability

    def initialize(_user)
      can :index, Internship
      can :list, Internship
      can :read, :all
      can :map_internships, Internship
      can :create, InternshipOffer
    end
  end
end
