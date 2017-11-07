# frozen_string_literal: true

# Where the Report can be found.
class ReportState < ApplicationRecord
  # attr_accessible :name, :name_de

  has_many :internships
end
