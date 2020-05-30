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

  has_many :user_can_see_internship
  has_many :seeing_users,
           through: :user_can_see_internship,
           source: :user,
           inverse_of: :visible_internships

  # mount_uploader :internship_report, InternshipReportUploader

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

  def self.find_for(id:, action:, ability:)
    # The accessible_by call cannot be used with a block 'can' definition.
    #   .accessible_by(current_ability, :edit)
    instance = find(id)
    raise CanCan::AccessDenied unless ability.can? action, instance

    instance
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
                    tasks, working_hours,
                    supervisor_name, supervisor_email, supervisor_phone]
    helper_array.each do |e|
      return false if e.blank?
    end
    duration.valid_duration?(self)
  end

  module InternshipSearch
    def collect_results
      internships = Internship.where('start_date < CURRENT_DATE')
      internships = filter(internships)
      internships = sort_results(internships)
      internships
    end

    def pick_random_results(internships)
      return internships unless internships
      return internships if current_user.admin?

      internships = internships.sample(UserCanSeeInternship.limit)
      internships = internships.select do |i|
        UserCanSeeInternship.internship_search(internship_id: i.id,
                                               user: current_user)
      end
      internships = viewed_internships(internships)
      internships = sort_results(internships)
      internships
    end

    def show_one_random_result(internship)
      return internship unless internship
      return internship if current_user.admin?

      internships = internship.sample(UserCanSeeInternship.limit)
      internships = internships.select do |i|
        UserCanSeeInternship.internship_search(internship_id: i.id,
                                               user: current_user)
      end
      internships
    end

    def pick_random_internship
      @search = Search.new
      internships = sort_by_age
      internships = internships.shuffle
      @results = Array.new(1, internships[0])
    end
  end

  module InternshipSort
    def sort_results(internships)
      return internships unless internships

      internships = internships.sort_by do |i|
        if i.start_date.nil?
          Date.new(1990, 1, 1)
        else
          i.start_date
        end
      end
      internships = internships.reverse
      internships
    end

    def sort_by_age
      internships = Internship.order(start_date: :desc)
      internships = internships.where('start_date > ?', 2.years.ago)
      internships
    end

    def filter(internships)
      internships = filter_paid(internships)
      internships = filter_location(internships)
      internships = filter_orientation_id(internships)
      internships = filter_pl(internships)
      internships
    end

    def filter_paid_true(internships)
      internships = internships.select do |i|
        # i.payment_state_id == 2 => "cash benefit"
        i.payment_state_id == 2 || i.salary.try(:positive?)
      end
      internships
    end

    def filter_paid_false(internships)
      internships = internships.select do |i|
        i.payment_state_id != 2 && (i.salary.nil? || i.salary <= 0)
      end
      internships
    end

    def filter_paid(internships)
      return internships if @search.paid.nil?
      return internships unless internships

      if @search.paid == true
        internships = filter_paid_true(internships)
      elsif @search.paid == false
        internships = filter_paid_false(internships)
      end
      internships
    end

    def filter_location(internships)
      loc = @search.location
      return internships unless loc
      return internships if loc.empty?

      return internships unless internships

      internships = internships.select do |i|
        city_matches = i.company_address.try(:city) == loc
        country_matches = i.company_address.try(:country_name) == loc
        city_matches || country_matches
      end
      internships
    end

    def filter_orientation_id(internships)
      return internships unless @search.orientation_id

      return internships unless internships

      internships = internships.select do |i|
        i.orientation_id == @search.orientation_id
      end
      internships
    end

    def filter_pl(internships)
      return internships unless @search.programming_language_id

      return internships unless internships

      internships = internships.select do |i|
        i.programming_language_ids.include?(@search.programming_language_id)
      end
      internships
    end

    def viewed_internships(internships)
      if internships.count < 12
        internships += Internship.where(id:
          UserCanSeeInternship
          .where(user: current_user).map(&:internship_id))
        internships = internships.uniq
        internships = filter(internships)
      end
      internships
    end
  end
end
