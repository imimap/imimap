class StatisticController < ApplicationController
  def show
    @internships = Internship.all
  end
end