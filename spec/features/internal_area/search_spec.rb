require 'rails_helper'

describe "Detailed Search Page " do
  I18n.available_locales.each do | locale |
  context "in locale #{locale}" do
    before :each do
      I18n.locale = locale
    end
    #context "with valid user credentials" do
      before :each do
        @user = create(:user)
      end

    it "should have title and arbitrary search criteria" do
      login_with(@user)
        visit internships_path(locale: locale)
      #  save_and_open_page
        page.should have_content(t('search.title'))
        page.should have_content(t('internships.attributes.living_costs'))
     end
  # end
 end
end
end
