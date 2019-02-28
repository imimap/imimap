# frozen_string_literal: true

require 'rails_helper'

# see https://thoughtbot.com/blog/how-we-test-rails-applications#view-specs

RSpec.describe 'welcome/help.html.erb', type: :view do
  it 'renders the help page' do
    render
    expect(rendered).to have_content(t('welcome.help.header'))
  end
end
