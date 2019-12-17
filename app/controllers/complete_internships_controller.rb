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
  before_action :set_student, only: %i[show]

  def index
    @semester = semester_from_params(params)
    @semester_options = semester_select_options
    @complete_internships = CompleteInternship.where(semester: @semester)
    @complete_internships_count = @complete_internships.size
  end

  def show
    @semester_name = @complete_internship.semester.try(:name)
    # set_student(@complete_internship)
  end

  # If the user has no complete internship, the system asks him/her to create a
  # new one else the internship details are shown
  # my_internship_path
  def show_own
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

  private

  def new_complete_internship
    @complete_internship = complete_internship_from_params
    si = if @current_user.student.nil?
           params[:complete_internship][:student_id]
         else
           @current_user.student.id
         end
    @complete_internship.student_id = si
  end

  def complete_internship_from_params
    if params[:complete_internship].nil?
      CompleteInternship.new
    else
      CompleteInternship.new(complete_internship_params)
    end
  end

  def complete_internship_params
    params.require(:complete_internship).permit(
      CompleteInternshipsController.permitted_params
    )
  end

  def set_semesters
    @semesters = Semester.all.pluck(:name, :id)
  end

  def set_student
    if current_user.student?
      @student = current_user.student
    else
      student = @complete_internship.student
      @student = (student if can?(:read, student))
    end
  end
end
