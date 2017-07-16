class InternshipStatisticController < ApplicationController
  def index
    @internship = Internship.first
    @internships = Internship.all
    @companies = Company.all
  end
end