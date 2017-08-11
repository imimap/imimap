class Internship < ActiveRecord::Base

  attr_accessible :attachments_attributes, :living_costs, :orientation_id, :salary, :working_hours, :programming_language_ids, :internship_rating_id,
    :company_id, :user_id, :title, :recommend, :email_public, :semester_id, :description, :internship_report, :student_id, :start_date, :end_date, :operational_area, :tasks, :internship_state_id, :reading_prof_id, :payment_state_id, :registration_state_id, :contract_state_id, :report_state_id, :certificate_state_id, :certificate_signed_by_internship_officer, :certificate_signed_by_prof,
    :certificate_to_prof, :comment, :supervisor_email, :supervisor_name, :internship_rating_attributes, :completed
  validates :semester_id, :student, presence: true
  #validate :start_date_before_end_date?


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
  has_many :user_comments, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :answers

  mount_uploader :internship_report, InternshipReportUploader

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :internship_rating
  accepts_nested_attributes_for :company, reject_if: proc { |attributes| attributes{'name'}.blank? }

  def rating
    internship_rating.total_rating
  end

  def editable?
    if self.report_state.try(:name) != "missing"  && self.student.try(:has_user?) && !self.completed
      true
    else
      false
    end
  end

  def enrolment_number
    student.enrolment_number
  end

  def start_date_before_end_date?
    if (:start_date > :end_date)
      errors.add :end_date, "must be after start date"
    end
  end

  def weekCount
    days = (self[:end_date] - self[:start_date]).to_i
    weeks = days/7
    return weeks
  end

  def weekValidation
    weeksToValidate = weekCount
    valText = ""
    case weeksToValidate
      when 0..4
        valText = "A" 
      when 4..17,5
         valText = "B"
       else
        valText = "C"
    end
    return valText;

  end

  # expected hand in 4 weeks after end of internship time
  def vorraussichtliche_abgabe
    #self[:end_date].to_time + 4.weeks
  end


  def weekValidationActAdm
     weeksToValidate = weekCount
     valText = ""
     case weeksToValidate
       when 0..4
         valText = "Intership is less than 4 weeks"
       when 4..17,5
          valText = "Internship needs manual validation"
        else
         valText = "Internship is long enough"
      end
      return valText;
   end   

   def self.to_csv
    CSV.generate do |csv|
      csv << %w{semester enrolment_number student start_date end_date } 
      all.each do|internship|
        csv << [internship.semester.name, internship.student.enrolment_number, internship.student.name, internship.start_date, internship.end_date]
      end 
    end

  end

end
