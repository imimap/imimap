# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin index programming_languages' do
  before :each do
    sign_in create(:admin_user)
    @langs = [create(:forth),
              create(:whitespace),
              create(:velato),
              create(:brainfuck),
              create(:piet)]
  end
  it 'shows internships details headers' do
    visit admin_programming_languages_path
    @langs.each do |language|
      expect(page).to have_content language.name
    end
  end
  it 'shows single language ' do
    language = @langs[0]
    visit admin_programming_language_path(locale: 'de', id: language.id)
    expect(page).to have_content(language.name)
  end
end
