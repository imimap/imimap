class InternshipStatisticController < ApplicationController
  def index
    @internship = Internship.new
    @internships = Internship.all
  end
end