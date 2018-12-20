# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Semester, type: :model do
  it 'finds existing semester' do
    date = '2016-01-15'
    semester_name = 'WS 15/16'
    existing = Semester.create(name: semester_name)
    s = Semester.for_date(date)
    expect(s.id).to eq existing.id
  end

  it "doesn't create a new one if existing" do
    date = '2014-05-15'
    semester_name = 'SS 14'
    Semester.create(name: semester_name)
    expect do
      Semester.for_date(date)
    end.to change { Semester.count }.by(0)
  end

  it 'creates a new one if needed' do
    expect do
      Semester.for_date('2009-02-10')
    end.to change { Semester.count }.by(1)
  end
end
