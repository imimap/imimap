# frozen_string_literal: true

require 'rails_helper'
Prawn::Font::AFM.hide_m17n_warning = true

describe 'the generation of the application pdf does not produce errors' do
  def create_internship
    create(:semester)
    visit my_internship_path
    click_link(t('internships.provide_now'))
    click_on t('save')
    click_on t('complete_internships.new_tp0')
    click_on t('save')
  end

  context 'factory user' do
    before :each do
      @user = create(:user)
      sign_in(@user)
      create_internship
    end
    it 'entered no additional information' do
      expect { click_link(t('complete_internships.checklist.print_form')) }
        .not_to raise_error
    end
  end
end
