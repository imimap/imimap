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
        ['activerecord.attributes.internship.start_date',
         'activerecord.attributes.internship.end_date',
         'activerecord.attributes.internship.tasks',
         'activerecord.attributes.internship.supervisor_email',
         'activerecord.attributes.internship.supervisor_name',
         'activerecord.attributes.internship.comment'].each do |i18n_key|
          expect(page).to have_content(I18n.t(i18n_key))
        end
      end
    end
  end
end
