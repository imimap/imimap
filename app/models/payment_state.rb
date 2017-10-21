# frozen_string_literal: true

# Categories for Internship Payments
class PaymentState < ActiveRecord::Base
  attr_accessible :name, :name_de

  has_many :internships
end
