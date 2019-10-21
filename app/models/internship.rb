# frozen_string_literal: true

require 'date'
require 'time'
# Internship respresents one actual internship within one company, as opposed
# to CompleteInternship that respresents the whole course B20.
class Internship < ApplicationRecord
  after_initialize do
    self.approved = false if approved.nil?
  end
  validates :semester, :complete_internship, presence: true
  validates :approved, inclusion: { in: [true, false] }
  # validates_presence_of :company_address

  belongs_to :user
  belongs_to :company
  belongs_to :company_address
  belongs_to :orientation
  belongs_to :semester
  belongs_to :internship_rating
  # belongs_to :student
  belongs_to :complete_internship
  has_one :student, through: :complete_internship
  belongs_to :internship_state
  belongs_to :payment_state
  belongs_to :registration_state
  belongs_to :internship
  belongs_to :contract_state
  belongs_to :report_state
  belongs_to :certificate_state
  belongs_to :reading_prof

  has_and_belongs_to_many :programming_languages, -> { distinct }
  has_many :favorites, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  mount_uploader :internship_report, InternshipReportUploader

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :internship_rating
  # TBD: Test this. It probably didn't work before cleaning up the style.
  accepts_nested_attributes_for :company,
                                reject_if: proc { |attr| attr['name'].blank? }
  accepts_nested_attributes_for :programming_languages
  def self.attributes_required_for_internship_application
    %i[semester start_date end_date
       working_hours tasks operational_area
       supervisor_name supervisor_email supervisor_phone]
  end

  def rating
    internship_rating.total_rating
  end

  def company?
    company.present?
  end

  def company_v2
    if company_address.nil?
      'no_company'
    else
      company_address.company
    end
  end

  def company_name
    if company_address.nil?
      'no_company'
    else
      company_address.company.name
    end
  end

  def duration
    @duration || @duration = InternshipDuration.new(self)
  end
  after_save do
    @duration = nil
  end

  def passed?
    return true if internship_state && internship_state.name == 'passed'

    !certificate_signed_by_internship_officer.nil?
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

  def all_internship_details_filled?
    helper_array = [start_date, end_date, operational_area,
                    orientation_id, tasks, working_hours,
                    supervisor_name, supervisor_email, supervisor_phone]
    helper_array.each do |e|
      return false if e.blank?
    end
    true
  end
end
