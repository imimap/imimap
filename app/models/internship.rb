# frozen_string_literal: true

require 'date'
require 'time'
# THE Internship
class Internship < ApplicationRecord
  validates :semester_id, :student, presence: true

  validates_presence_of :company_address

  belongs_to :user
  belongs_to :company
  belongs_to :company_address
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

  has_and_belongs_to_many :programming_languages, -> { distinct }
  has_many :user_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :read_list, dependent: :destroy
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

  # TBD this makes no here.
  def enrolment_number
    student.enrolment_number
  end

  def company_v2
    nil unless company_address
    company_address.company
  end

  def company_name
    nil unless company_address
    company_address.company.name
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
    if self[:end_date].nil?
      Time.now.strftime('%Y-%m-%d')
    else
      d = self[:end_date].to_time + 4.weeks
      d.strftime('%Y-%m-%d')
    end
  end
end
