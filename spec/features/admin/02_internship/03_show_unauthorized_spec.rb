# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin show internship' do
  context 'not logged in' do
    describe 'show internship' do
      it 'shows unauthenticated failure' do
        I18n.locale = :en
        expected_text = I18n.t('devise.failure.unauthenticated')
        internship = create(:internship)
        visit admin_internship_path(locale: :en, id: internship)
        expect(page).to have_content expected_text
      end
    end
  end
end
