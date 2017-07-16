
require 'rails_helper'

describe "Detailed Search Page " do
  before :each do
    @user = create(:user)
  end
    it "should have content " do
      login_with(@user)
        visit "/de/internships"
        page.should have_content("Lebenshaltungskosten")
        page.should have_content("Gehalt")
        click_link "English"
        page.should have_content("Cost of living")
        page.should have_content("salary")
        page.should have_content(I18n.t('results.found'))
        select('SS 13', :from => 'semester')
        select('Brazil', :from => 'Choose a country')
        select('United Kingdom', :from => 'country')
        select('SS 12', :from => 'Choose a semester')
        click_button "submit"
        click_button "reset_chosen"
     end
end
