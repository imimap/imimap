# frozen_string_literal: true

# Ability definitions for Users
module Abilities
  # defines abilities for plain users(students)
  class User
    include CanCan::Ability

    def initialize(user)
      can_create_internship(user)
      can_show_own_internship(user)
      can_edit_own_complete_internship(user)
      can_edit_destroy_own_internship(user)
      can_create_and_show_own_postponement(user)
      can_create_search(user)

      map(user)
      can :read, InternshipOffer

      can %i[read update], Student, user: { id: user.id }

      can %i[read update], User, id: user.id
    end

    def can_create_search(_user)
      can %i[start_search show_results confirm_results
             shuffle no_more_results], Search
    end

    def can_create_and_show_own_postponement(_user)
      can %i[new create], Postponement
    end

    def can_create_internship(_user)
      can %i[new create show_own], CompleteInternship
      can %i[create new], Internship
    end

    def can_show_own_internship(user)
      can %i[no show_own], CompleteInternship
      can %i[show], CompleteInternship,
          student: { user: { id: user.id } }
      can %i[show], Internship, student: { user: user }
    end

    def can_edit_own_complete_internship(user)
      can %i[edit update],
          CompleteInternship do |ci|
            # student: { user: { id: user.id } }
            if ci.student.user == user
              !ci.aep
            else
              false
            end
          end
    end

    def can_edit_destroy_own_internship(user)
      # evtl. vereinfachen zu
      # can :update, Internship, approved: false,  student: { user: user }
      can %i[edit update destroy], Internship do |internship|
        if internship.complete_internship.student.user == user
          !internship.approved && internship.registration_state.nil?
        else
          false
        end
      end
    end

    def map(_user)
      can :map_cities, Internship
    end
  end
end
