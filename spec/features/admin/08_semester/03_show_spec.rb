# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Semester Show' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    @semester = create(:ws2019)
    @internship1 = create(:internship_1, semester: @semester)
    @internship2 = create(:internship_2, semester: @semester)
  end
  it 'shows semester' do
    visit admin_semester_path(id: @semester)
    expect(page).to have_content @semester.name
    expect(page).to have_content @internship1.id
    expect(page).to have_content @internship2.id
  end
end
