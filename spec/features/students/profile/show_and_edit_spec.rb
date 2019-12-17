# frozen_string_literal: true

require 'rails_helper'

describe 'Student Profile' do
  # I18n.available_locales.each do |locale|
  locale = :en
  student_fields = %w[first_name last_name birthday birthplace private_email]
  context "in locale #{locale}" do
    before :each do
      I18n.locale = locale
    end

    context 'user with everything' do
      before :each do
        @user = create(:user)
        sign_in @user
      end

      it 'should show existing student profile data' do
        s = @user.student
        visit student_path(locale, s)
        student_fields.each do |field|
          value = s.send(field)

          expect(page).to have_selector("input[value='#{value}']")
        end
      end
      it 'should edit and save student profile data' do
        s = @user.student
        visit student_path(locale, s)
        other_s = build(:student2)
        fields_and_values = student_fields.map { |f| [f, other_s.send(f)] }
        fields_and_values.each do |field, value|
          fill_in("student_#{field}", with: value)
        end
        click_on t('helpers.submit.generic_update')
        fields_and_values.each do |_field, value|
          expect(page).to have_selector("input[value='#{value}']")
        end
      end
    end
  end
  # end
end

# I18n.t('students.attributes.first_name')
# t.string "enrolment_number"
# t.string "last_name"
# t.string "first_name"
# t.date "birthday"
# t.string "birthplace"
# t.string "email"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.integer "import_id"
# t.string "city"
# t.string "street"
# t.string "zip"
# t.string "phone"
# t.string "private_email"
