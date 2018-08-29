# frozen_string_literal: true

require 'rails_helper'

describe 'The Dashboard' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    @internship = create(:internship)
  end
  it 'shows internship and students' do
    visit admin_root_path
    expect(page).to have_content @internship.company_v2.name
    expect(page).to have_content @internship.student.first_name
    expect(page).to have_content @internship.student.last_name
  end
end
