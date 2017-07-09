class InternshipStatisticController < ApplicationController
  def index
	    @internships = Internship.all
  end
end