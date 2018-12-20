# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  it 'orders semesters' do
    semester = Semester.for_date('2018-12-10')
    next_semester = semester.next
    expect(next_semester.name).to eq 'SS 19'
  end

  it 'knows current semester' do
    expect(Semester.current).to eq Semester.for_date(Date.today)
  end
end
