class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #has_secure_password

  attr_accessible :email, :password, :password_confirmation, :publicmail, :mailnotif, :student_id, :remember_me


  validates :email, :presence => true
  validates :password, :presence => true, length: { minimum: 5 }
  validates :student, :presence => true

  belongs_to :student
  has_many :user_comments, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :read_lists, :dependent => :destroy

  def name
    "#{student.first_name} #{student.last_name}"
  end

  def enrolment_number
    student.enrolment_number if student
  end

  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save(:validate => false)
    UserMailer.forgot_pwd(self).deliver_later
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
