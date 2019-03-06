# frozen_string_literal: true

# this was generated by g scaffold due to the gem inherited_resources
# https://github.com/activeadmin/inherited_resources
# TBD: needs to be consolidated with our ApplicationResourceController
class CompleteInternshipsController < ApplicationResourceController
  # InheritedResources::Base
  # authorize_resource
  before_action :set_complete_internship, only: %i[show edit update destroy]
  before_action :new_complete_internship, only: %i[create new]
  before_action :set_semesters, only: %i[new edit]

  def index
    @complete_internships = CompleteInternship.all
  end

  def show; end

  def new
    @complete_internship = CompleteInternship.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @complete_internship.save
        format.html do
          redirect_to @complete_internship,
                      notice: 'CompleteInternship was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @complete_internship.update(complete_internship_params)
        format.html do
          redirect_to @complete_internship,
                      notice: 'CompleteInternship was successfully updated.'
        end
      else
        format.html { render :edit }

      end
    end
  end

  def destroy
    @complete_internship.destroy
    respond_to do |format|
      format.html do
        redirect_to complete_internships_url,
                    notice: 'CompleteInternship was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_complete_internship
    @complete_internship = CompleteInternship.find(params[:id])
    @semester_name = @complete_internship.semester.try(:name)
  end

  def new_complete_internship
    @complete_internship = CompleteInternship.new(complete_internship_params)
  end

  def set_semesters
    @semesters = Semester.all.pluck(:name, :id)
  end

  def complete_internship_params
    params.require(:complete_internship)
          .permit(:semester_id, :semester_of_study, :aep, :passed)
  end
end
