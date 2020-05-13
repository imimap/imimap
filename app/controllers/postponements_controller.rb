# frozen_string_literal: true

# Postponements are created if a students requests a postponement
# of their internship.
class PostponementsController < ApplicationResourceController
  include CompleteInternshipsHelper
  # < InheritedResources::Base
  load_and_authorize_resource

  def create
    @postponement.placed_at = DateTime.now
    create_respond(success: @postponement.save, postponement: @postponement)
  end

  def create_respond(success:, postponement:)
    respond_to do |format|
      if success
        format.html do
          redirect_to postponement.complete_internship,
                      notice: 'Postponement was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def new
    @complete_internship = CompleteInternship.find(params[:complete_internship])
    @semester = @complete_internship.semester || Semester.next
    @semester_options = semester_select_options
    @postponement.semester_of_study = @complete_internship.semester_of_study
  end

  def approve
    # @postponement = Postponement.find(params[:id])
    @postponement.approved_by_id = current_user.id
    @postponement.approved_at = DateTime.now
    approve_respond(success: @postponement.save)
  end

  def approve_respond(success:)
    respond_to do |format|
      if success
        format.html do
          redirect_to :postponements,
                      notice: 'Postponement was successfully approved.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  private

  def postponement_params
    params.require(:postponement)
          .permit(:student_id,
                  :semester_id,
                  :semester_of_study,
                  :placed_at,
                  :reasons)
  end
end
