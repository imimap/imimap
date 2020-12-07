# frozen_string_literal: true

# Postponements are created if a students requests a postponement
# of their internship.
class PostponementsController < ApplicationResourceController
  include CompleteInternshipsHelper
  # < InheritedResources::Base
  load_and_authorize_resource

  def index
    @postponements = Postponement.all.order('postponements.created_at DESC')
  end

  def destroy
    @postponement.destroy
    redirect_to postponements_url,
                notice: 'Postponement was successfully destroyed.'
  end

  def update
    respond_to do |format|
      if @postponement.update(postponement_params)
        format.html do
          redirect_to @postponement, notice: 'Postponement was successfully updated.'
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def create
    @postponement.placed_at = DateTime.now
    create_respond(success: @postponement.save, postponement: @postponement)
  end

  def create_respond(success:, postponement:)
    respond_to do |format|
      if success && postponement.complete_internship
        format.html do
          redirect_to postponement.complete_internship,
                      notice: I18n.t('postponements.successfully_created')
        end
      elsif success
        format.html do
          redirect_to no_complete_internship_path,
                      notice: I18n.t('postponements.successfully_created')
        end
      else
        format.html { render :new }
      end
    end
  end

  def new
    if params[:complete_internship]
      @complete_internship = CompleteInternship.find(params[:complete_internship])
      @semester = @complete_internship.semester || Semester.next
      @postponement.semester_of_study = @complete_internship.semester_of_study
     end
      @semester_options = semester_select_options
  end

  def approve
    # @postponement = Postponement.find(params[:id])
    @postponement.approved_by_id = current_user.id
    @postponement.approved_at = DateTime.now
    if params[:admin]
      admin_approve_respond(success: @postponement.save)
    else
      approve_respond(success: @postponement.save)
    end
  end

  def admin_approve_respond(success:)
    respond_to do |format|
      if success
        format.html do
          redirect_to :admin_postponements,
                      notice: I18n.t('postponements.successfully_approved')
        end
      else
        format.html { render :edit_admin_postponement }
      end
    end
  end

  def approve_respond(success:)
    respond_to do |format|
      if success
        format.html do
          redirect_to :postponements,
                      notice: I18n.t('postponements.successfully_approved')
        end
      else
        format.html { render :edit }
      end
    end
  end

  def self.permitted_params
    %i[student_id semester_id semester_of_study placed_at reasons admin]
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
