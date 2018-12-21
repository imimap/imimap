# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Student CRUD' do
  context 'not logged in' do
    describe 'show student' do
      it 'shows unauthenticated failure' do
        I18n.locale = 'de'
        expected_text = I18n.t('devise.failure.unauthenticated')
        student = create(:student)
        visit admin_student_path(id: student)
        expect(page).to have_content expected_text
      end
    end
  end
end
