# frozen_string_literal: true

require 'date'
require 'time'
# THE Internship
class Internship < ActiveRecord::Base
  attr_accessible :attachments_attributes, :living_costs, :orientation_id,
                  :salary, :working_hours, :programming_language_ids,
                  :internship_rating_id, :company_id, :user_id, :title,
                  :recommend, :email_public, :semester_id, :description,
                  :internship_report, :student_id, :start_date, :end_date,
                  :operational_area, :tasks, :internship_state_id,
                  :reading_prof_id, :payment_state_id, :registration_state_id,
                  :contract_state_id, :report_state_id, :certificate_state_id,
                  :certificate_signed_by_internship_officer,
                  :certificate_signed_by_prof, :certificate_to_prof, :comment,
                  :supervisor_email, :supervisor_name,
                  :internship_rating_attributes, :completed
  validates :semester_id, :student, presence: true

  validates_presence_of :company

  belongs_to :user
  belongs_to :company
  belongs_to :orientation
  belongs_to :semester
  belongs_to :internship_rating
  belongs_to :student
  belongs_to :internship_state
  belongs_to :payment_state
  belongs_to :registration_state
  belongs_to :internship
  belongs_to :contract_state
  belongs_to :report_state
  belongs_to :certificate_state
  belongs_to :reading_prof

  has_and_belongs_to_many :programming_languages, -> { uniq }
  has_many :user_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :read_list, :dependent => :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :answers

  mount_uploader :internship_report, InternshipReportUploader

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :internship_rating
  # TBD: Test this. It probably didn't work before cleaning up the style.
  accepts_nested_attributes_for :company,
                                reject_if: proc { |attr| attr['name'].blank? }

  def rating
    internship_rating.total_rating
  end

  def editable?
    report_state.try(:name) != 'missing' &&
      student.try(:user?) && !completed
  end

  def enrolment_number
    student.enrolment_number
  end

  def duration
    @duration || @duration = InternshipDuration.new(self)
  end
  after_save do
    @duration = nil
  end


  # CodeReviewSS17
  # CSV is a view and should not be in the model.
  # modify to accept hash options for .xls file (needed for prof reports?)
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      # CodeReviewSS17 this duplicates field names
      csv << %w[semester enrolment_number student start_date end_date]
      all.each do |internship|
        csv << [internship.semester.name, internship.student.enrolment_number,
                internship.student.name, internship.start_date,
                internship.end_date]
      end
    end
  end

  # CodeReview: form and logic of missing end date needs to be adapted
  # expected hand in 4 weeks after end of internship time
  def expected_hand_in
    if ( self[:end_date].nil? )
      Time.now.strftime('%Y-%m-%d')
    else
      d = self[:end_date].to_time + 4.weeks
      d.strftime('%Y-%m-%d')
    end
  end
end
