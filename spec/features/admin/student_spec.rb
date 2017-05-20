
require 'rails_helper'

describe "ActiveAdmin Student CRUD" do
  context "logged in" do
    before :each do
      @admin_user = create :admin_user
      login_as(@admin_user, :scope => :admin_user)
      I18n.locale = "de"
    end
    describe "show student" do
      it "shows student" do
        student = create(:student)
        visit admin_student_path(student)
        expect(page).to have_content student.first_name
        expect(page).to have_content student.last_name
        expect(page).to have_content student.enrolment_number
        expect(page).to have_content student.birthplace
        expect(page).to have_content student.email
      end
    end
  end
  context "not logged in" do
    describe "show student" do
      it "shows unauthenticated failure" do
        I18n.locale = "de"
        expected_text = I18n.t('devise.failure.admin_user.unauthenticated')
        student = create(:student)
        visit admin_student_path(student)
        expect(page).to have_content expected_text
      end
    end
  end
end
