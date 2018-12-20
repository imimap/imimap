# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  def test_data
    [['2018-12-10', 'WS 18/19'], ['2018-06-10', 'SS 18'],
     ['2018-04-01', 'SS 18'], ['2011-09-30', 'SS 11'],
     ['2007-10-01', 'WS 07/08'], ['2012-03-31', 'WS 11/12'],
     ['2009-02-10', 'WS 08/09'], ['2010-02-10', 'WS 09/10'],
     ['2016-01-15', 'WS 15/16'], ['2014-05-15', 'SS 14']]
  end
  it 'puts dates in correct semesters' do
    test_data.each do |date, semester_name|
      semester = Semester.for_date(date)
      expect(semester.name).to eq semester_name
    end
  end
end
