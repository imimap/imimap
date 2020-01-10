# frozen_string_literal: true

require 'rails_helper'
Prawn::Font::AFM.hide_m17n_warning = true

describe 'the generation of the application pdf does not produce errors' do
  def create_internship
    create(:semester)
    visit my_internship_path_replacement
    click_link(t('internships.provide_now'))
    click_on t('save')
    click_on t('complete_internships.new_tp0')
    click_on t('save')
  end

  # copied from this page:
  # https://content.pivotal.io/blog/how-to-test-pdfs-with-capybara
  # pdf-reader gem is used here
  def convert_pdf_to_page
    temp_pdf = Tempfile.new('pdf')
    temp_pdf << page.source.force_encoding('UTF-8')
    reader = PDF::Reader.new(temp_pdf)
    pdf_text = reader.pages.map(&:text)
    page.driver.response.instance_variable_set('@body', pdf_text)
  end

  context 'factory user' do
    before :each do
      @user = create(:user)
      sign_in(@user)
      create_internship
    end
    it 'entered no additional information' do
      expect { click_link('pdf') }
        .not_to raise_error
    end
    it 'and generate a valid pdf containing student name' do
      click_link('pdf')
      convert_pdf_to_page
      expect(page).to have_content(@user.student.first_name)
    end
  end
end
