# frozen_string_literal: true

#
class ReportState < ActiveRecord::Base
  attr_accessible :name, :name_de

  has_many :internships
end
