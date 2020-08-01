# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin Semester / Index' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    semester_keys = %i[semester ss2018 ws2018 ss2019 ws2019]
    @semesters = semester_keys.map { |k| create(k) }
  end
  it 'shows semester index details headers' do
    visit admin_semesters_path
    @semesters.each do |semester|
      expect(page)
        .to have_content semester.name
    end
  end
end
