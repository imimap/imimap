# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with valid user credentials' do
        before :each do
          @user = login_as_student
        end

        it 'should create a new CI' do
          visit my_internship_path
          expect(page).to have_content('Praktikumsdetails')
          click_link(t('internships.createYourInternship'))
          expect(page).to have_field('Semester')
          expect(page).to have_field('Fachsemester')
          click_on t('save')
          expect(page).to have_content(@user.name)
        end

        it 'should create a new partial internship' do
          create(:semester)
          visit my_internship_path
          click_link(t('internships.createYourInternship'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content('Tuennes Schael')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          expect(page).to have_content(
            t('complete_internships.parcial_internships.number')
          )
          expect(page).to have_content(
            t('complete_internships.ci.number')
          )
          expect(page).to have_content(Semester.last.name)
        end

        # t("complete_internships.checklist.personal_details")
        # t("complete_internships.checklist.internship_details")

        it 'should save changes made in internship datails form
            (example reading_prof selection)' do
          create(:semester)
          create(:reading_prof1)
          create(:reading_prof2)
          create(:reading_prof3)
          visit my_internship_path
          click_link(t('internships.createYourInternship'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          click_on t('save')
          click_link(t('complete_internships.checklist.internship_details'))
          expect(page).to have_content(
            t('internships.attributes.which_professor_should_read')
          )
          select 'Prof. 3', from: 'internship_reading_prof_id'
          click_on t('save')
          click_link(t('complete_internships.checklist.internship_details'))
          expect(page).to have_select('internship_reading_prof_id',
                                      selected: 'Prof. 3')
        end
      end
    end
  end
end
