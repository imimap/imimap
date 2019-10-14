# frozen_string_literal: true

# CompleteInternship represent the module for a student,
# spanning up to three actual Internships.
class CompleteInternshipsController < ApplicationResourceController
  include ApplicationHelper
  include CompleteInternshipsHelper
  # InheritedResources::Base
  load_and_authorize_resource
  # before_action :set_complete_internship, only: %i[show edit update destroy]
  before_action :new_complete_internship, only: %i[create new]
  before_action :set_semesters, only: %i[create new edit internship_data]

  def index
    @semester = semester_from_params(params)
    @semester_options = semester_select_options
    @complete_internships = CompleteInternship.where(semester: @semester)
    @complete_internships_count = @complete_internships.size
  end

  def show
    @semester_name = @complete_internship.semester.try(:name)
  end

  def new; end

  def edit; end

  def create
    respond_to do |format|
      if @complete_internship.save
        format.html do
          redirect_to @complete_internship, notice: 'Successfully created.'
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

  def self.permitted_params
    %i[student_id semester_id semester_of_study aep passed]
  end

  # If the user has no complete internship, the system asks him/her to create a
  # new one else the internship details are shown
  # my_internship_path
  def internship_data
    @ci = if current_user.student.nil?
            []
          else
            current_user.student.complete_internship
          end

    if @ci.nil?
      render :no_complete_internship_data
    else
      redirect_to @ci
    end
  end

  private

  def new_complete_internship
    @complete_internship = CompleteInternship.new(complete_internship_params)
    si = if @current_user.student.nil?
           params[:complete_internship][:student_id]
         else
           @current_user.student.id
         end
    @complete_internship.student_id = si
  end

  def set_semesters
    @semesters = Semester.all.pluck(:name, :id)
  end

  def complete_internship_params
    params.require(:complete_internship).permit(
      CompleteInternshipsController.permitted_params
    )
  end
end
