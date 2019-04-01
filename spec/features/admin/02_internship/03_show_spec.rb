# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin show internship' do
  context 'logged in' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
    end
    describe 'show internship' do
      it 'shows internship' do
        internship = create(:internship)
        visit admin_internship_path(id: internship)
        expect(page).to have_content active_admin_date(internship.start_date)
        expect(page).to have_content active_admin_date(internship.end_date)
        expect(page).to have_content internship.tasks
        expect(page).to have_content internship.comment
        expect(page).to have_content internship.supervisor_email
        expect(page).to have_content internship.supervisor_name
      end
      it 'renders with an unassociated internship' do
        internship2 = create(:unassociated_internship)
        visit admin_internship_path(id: internship2)
        expect(page).to have_content I18n.t('active_admin.no_student')
        expect(page).to have_content internship2.supervisor_email
      end
    end
  end
end
