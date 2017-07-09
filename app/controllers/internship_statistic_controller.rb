class InternshipStatisticController < ApplicationController
  def show
    @internships = Internship.all
    @companies = @internships.collect(&:company)
    @countries = @companies.collect(&:country)
    @internships = @internships.where(:companies => {:country => params[:country]}) if params[:country].present?
  end
end