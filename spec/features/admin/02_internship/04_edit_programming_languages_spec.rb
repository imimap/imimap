# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin edit internship' do
  before :each do
    sign_in create(:admin_user)
    @internship = create(:internship)
  end
  it 'updates associated programming_languages' do
    @programming_language = create(:programming_language)
    visit edit_admin_internship_path(id: @internship)
    select @programming_language.name,
           from: t('activerecord.attributes.internship.programming_language_ids')
    click_on t('helpers.submit.update', model: Internship.model_name.human)
    expect(page).to have_content @programming_language.name
  end
  it 'updates several programming_languages' do
    pls = %i[velato forth whitespace].map { |n| create(n) }
    nos = %i[omgrofl piet brainfuck].map { |n| create(n) }
    visit edit_admin_internship_path(id: @internship)
    pls.each do |pl|
      select pl.name,
             from: t('activerecord.attributes.internship.programming_language_ids')
    end
    click_on t('helpers.submit.update', model: Internship.model_name.human)
    pls.each { |pl| expect(page).to have_content pl.name }
    nos.each { |pl| expect(page).not_to have_content pl.name }
  end
end
