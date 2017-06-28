require 'spec_helper'

describe 'internship/show.html.erb' do
  context 'displayed in English'
    it 'it shows internship correctly' do
      let(:locale) {:en}
      internship = build(:internship)
      render

      rendered.should contain('1')
      rendered.should contain('Intership is less than 4 weeks')
      render.should have_content('Total amount of weeks')
      render.should have_content('Validation status')
  end
end
