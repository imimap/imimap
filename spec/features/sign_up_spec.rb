require 'rails_helper'

describe "SignUp Process" do
  before :each do
    I18n.locale = :de
  end
  context "(not logged in)" do
    it "shows the Sign up link on the root page" do
      visit root_path
      expect(page).to have_content I18n.t('sign_up.here')
    end

    it "verifies via ldap and creates a new user and student", js: true do
      visit root_path
      click_on I18n.t('sign_up.here')
      expect(page).to have_content 'Please log in with your laboratory account'
      fill_in 'user_name', with: 's0123456'
      fill_in 'password_entry', with: 'geheim'
      click_on 'Verify'
      #page.save_screenshot '~/tmp/poltergeist-screens/user.png'
      expect(page).to have_content I18n.t('users.logintitle')

      student = build(:student)
      fill_in 'user_creation_form_first_name', with: student.first_name
      fill_in 'user_creation_form_last_name', with: student.last_name
      fill_in 'user_creation_form_birthday', with: student.birthday
      fill_in 'user_creation_form_birthplace', with: student.birthplace
      fill_in 'user_creation_form_enrolment_number', with: student.enrolment_number
      fill_in 'user_creation_form_student_email', with: student.email

      fill_in 'user_creation_form_email', with: student.email

      fill_in 'user_creation_form_password', with: "geheim"
      fill_in 'user_creation_form_password_confirmation', with: "geheim"
      #save_and_open_page
      click_on 'submit'

      #TBD: check if user & student have been created
      # (maybe not working due to birthday format?)
      #created_user = User.last
      #expect(created_user.email).to eq student.email
      #created_student = Student.last
      #expect(created_student.first_name).to eq student.first_name
    end
  end


end
  #context "logged in" do
  #  before :each do
  #    @admin_user = create :admin_user
  #    login_as(@admin_user, :scope => :admin_user)
  #    I18n.locale = "de"
  #  end
  #end
