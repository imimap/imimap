# frozen_string_literal: true

# Helper methods for all CompleteInternship Checklist tests
module CompleteInternshipCheckListHelper
  def expect_to_be_on_my_internship_page
    expect(page).to have_content(@user.name)
    expect(page).to have_content(t('complete_internships.semester')
                                     .strip)
  end

  def create_complete_internship
    visit my_internship_path_replacement
    expect(page).to have_content('Praktikumsdetails')
    click_link(t('internships.provide_now'))
    click_on t('save')
    expect(page).to have_content(@user.name)
  end

  def create_internship
    create(:semester)
    visit my_internship_path_replacement
    click_on t('complete_internships.new_tp0')
    expect(page).to have_field('Semester')
    click_on t('save')
  end
end
