# frozen_string_literal: true

require 'rails_helper'

describe 'Internship limit' do
  def create_complete_internship
    @ci = create(:complete_internship_w_fresh_internship)
    @user = @ci.student.user
    visit complete_internship_path(id: @ci.id)
    expect(page).to have_content(t('complete_internships.semester'))
  end

  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end

      context 'is counted correctly' do
        before :each do
          login_as_admin
          create_complete_internship
        end

        context 'when making one query' do
          it 'with one result'

          it 'with no results'

          it 'with loads of results'
        end

        context 'when making multiple queries' do
          it 'with same result'

          it 'with different results'
        end
      end
    end
  end
end
