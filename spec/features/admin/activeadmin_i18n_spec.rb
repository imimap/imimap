# frozen_string_literal: true

require 'rails_helper'

describe 'I18n in ActiveAdmin specs' do
  before :each do
    @admin_user = create :admin_user
    sign_in(@admin_user)
  end
  after(:all) { I18n.locale = :en }

  it 'contains locale in path' do
    p = admin_internships_path
    expect(p).to eq('/admin/internships')
  end
  it 'sets locale to de on default' do
    visit admin_internships_path
    expect(I18n.locale).to eq :de
    expect(admin_internships_path).to eq('/admin/internships')
    expect(page)
      .to have_content I18n.t('activerecord.models.internship.other')
  end
  it 'path sets locale en' do
    visit '/en/admin/internships'
    expect(I18n.locale).to eq :en
  end
  it 'path sets locale de' do
    visit '/de/admin/internships'
    expect(I18n.locale).to eq :de
    expect(admin_internships_path).to eq '/admin/internships'
  end
end
