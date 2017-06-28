require 'spec_helper'


describe 'internships/show.html.erb' do
  before do
    @user = create(:user)
    view.stub(:current_user).and_return(@user)
    I18n.locale = locale
  end

  context 'displayed in English'
  let(:locale) {:en}
  it 'it shows internship correctly' do
      user = create(:user)
      internship = create(:internship)
      internship.user = user
      company = create(:company)

      generic = [Internship.new, Internship.new ]
      assign(:company, company)
      assign(:other_internships, generic )

      assign(:comment, UserComment.new)
      assign(:user_comments, internship.user_comments)
      assign(:internship, internship)
      render

      rendered.should have_content('1')
      rendered.should have_content('Intership is less than 4 weeks')
      render.should have_content('Total amount of weeks')
      render.should have_content('Validation status')
  end
end
