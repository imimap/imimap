# frozen_string_literal: true

require 'rails_helper'

describe 'internship - index selection' do
  before :each do
    @user = create(:admin)
    sign_in(@user)
    @semester1 = Semester.for_date('2015-05-08')
    @semester2 = Semester.for_date('2016-11-08')
    @internship1 = create(:internship_1, semester: @semester1)
    @internship2 = create(:internship_2, semester: @semester2)
  end
  it 'semester can be selected' do
    visit internships_path
    select @semester2.name, from: 'semester_select'
    click_on t('internships.index.select')
    click_on t('internships.index.export.csv')
    body = page.body
    expect(body.lines.size).to eq 2
    ci = InternshipsDtoHelper::InternshipsDto.from(@internship2)
    InternshipsDtoHelper::COMPLETE_INTERNSHIP_MEMBERS.each do |field|
      expect(body).to include(ci.send(field).to_s)
    end
  end
end
