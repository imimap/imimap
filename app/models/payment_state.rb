# frozen_string_literal: true

# Categories for Internship Payments
class PaymentState < ApplicationRecord
  attr_accessible :name, :name_de

  has_many :internships
end
