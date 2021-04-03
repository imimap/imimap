# frozen_string_literal: true

require 'rails_helper'
describe 'Additions to Checklist for admins' do
  def create_complete_internship
    @ci = create(:complete_internship_w_fresh_internship)
    visit complete_internship_path(id: @ci.id)
    expect(page).to have_content(t('complete_internships.semester'))
  end

  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'as admin' do
        before :each do
          login_as_admin
          create_complete_internship
        end

        context 'i can see' do
          context 'a list of the required modules' do
            it 'sorted by semester' do
              expect(page).to have_content(
                "1. Semester\n" \
                             'Informatik 1 ' \
                             'Computersysteme ' \
                             'Propädeutikum und Medientheorie ' \
                             'Mathematik für Medieninformatik 1 ' \
                             'Grundlagen der Webprogrammierung ' \
                             "1. Fremdsprache\n" \
                             "2. Semester\n" \
                             'Informatik 2 ' \
                             'Grundlagen Digitaler Medien ' \
                             'Netzwerke ' \
                             'Mathematik für Medieninformatik ' \
                             '2 Medienwirtschaft ' \
                             '2. Fremdsprache'
              )
            end
            it 'sorted by subjects' do
              expect(page).to have_content(
                'Informatik 1 ' \
                    'Informatik 2 ' \
                    'Mathematik für Medieninformatik 1 ' \
                    'Mathematik für Medieninformatik 2 ' \
                    'Grundlagen der Webprogrammierung ' \
                    'Grundlagen Digitaler Medien ' \
                    'Computersysteme ' \
                    'Netzwerke ' \
                    'Propädeutikum und Medientheorie ' \
                    'Medienwirtschaft ' \
                    'Fremdsprache 1 ' \
                    'Fremdsprache 2'
              )
            end
          end
          context 'links to the modules' do
            it 'sorted by semester' do
              expect(page).to have_button(
                t('complete_internships.checklist.module_semester')
              )
            end
            it 'sorted by subjects' do
              expect(page).to have_button(
                t('complete_internships.checklist.module_fgr')
              )
            end
          end
          context 'the number of internal comments' do
            it '' do
              expect(page).to have_content(
                "0 #{t('complete_internships.checklist.internal_comments')}"
              )
            end
          end
          context 'links to active admin' do
            it '#edit' do
              expect(page).to have_content '(In Active Admin'
              expect(page).to have_link(
                t('complete_internships.checklist.see_aa')
              )
            end
            it '#show' do
              expect(page).to have_content '(In Active Admin'
              expect(page).to have_link(
                t('complete_internships.checklist.edit_aa')
              )
            end
          end
        end
      end
    end
  end
end
