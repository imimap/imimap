require 'spec_helper'

describe "Overview Page" do
    include Capybara::DSL
      it "should allow to change language" do
        #@user6 = User.create!( password: "testIT", email: "test@imimaps.com", student_id: 1)
        #@user6.save
        #visit root_path
        #fill_in "email",  :with => @user6.email
        #fill_in "password",  :with => @user6.password
        #page.find('.signin-icon').click
        #@current_user=@user6
        #response.should render_template(:overview)
        #visit overview_index_path("de")
        #click_link "English"
        #current_path.should == "/en/overview"
        #click_link "Deutsch"
        #current_path.should == "/de/overview"
     end

    it "should have content" do
        #@user6 = User.create!( password: "testIT", email: "test@imimaps.com", student_id: 1) @user6.save
        #visit root_path
        #fill_in "email",  :with => @user6.email
        #fill_in "password",  :with => @user6.password
        #page.find('.signin-icon').click
        #@current_user=@user6
        #response.should render_template(:overview)
        #page.should have_content("Rating")
        #page.should have_content("Deutsch")
        #page.should have_content("English")
        #page.should have_content("Guide")
    end
end
