# frozen_string_literal: true

# Wasn't here for some reason; recreated to have a place for the permitted attributes
class StudentsController < ApplicationController
  def self.permitted_params
    %i[first_name last_name first_name enrolment_number birthplace birthday email]
  end
end
