# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do

    it 'name returns the correct name' do
      student = build :student
      expect(student.name).to eq "#{student.first_name} #{student.last_name}"
    end


  it 'returns the last created internship' do
    pending "complete_internship migration"
    student2 = create(:student2)
    internship1 = create(:internship_1, student: student2)
    internship2 = create(:internship_2, student: student2)
    internship1.student = student2
    internship2.student = student2
    internship1.save
    internship2.save
    expect(internship1.student).to eq student2
    expect(internship2.student).to eq student2
    expect(student2.internships.size).to eq 2
    expect(student2.last_internship).to eq internship2
  end
end
