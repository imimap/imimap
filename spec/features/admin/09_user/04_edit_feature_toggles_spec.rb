# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin edit user feature toggles' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    @user = create(:user, feature_toggles: [:feature_a])

    FT.for(:feature_a) do |_current_user|
      true
    end
    FT.for(:feature_b) do |_current_user|
      true
    end
  end

  it 'adds feature toggle' do
    visit admin_user_path(id: @user)
    click_on t('active_admin.edit_model', model: User.model_name.human)
    check :feature_b
    click_on t('formtastic.update', model: User.model_name.human)
    expect(page).to have_content :feature_b
  end

  it 'preserves feature toggle' do
    visit admin_user_path(id: @user)
    click_on t('active_admin.edit_model', model: User.model_name.human)
    check :feature_b
    click_on t('formtastic.update', model: User.model_name.human)
    expect(page).to have_content :feature_a
    expect(page).to have_content :feature_b
  end

  it 'removes feature toggle' do
    visit admin_user_path(id: @user)
    click_on t('active_admin.edit_model', model: User.model_name.human)
    uncheck :feature_a
    click_on t('formtastic.update', model: User.model_name.human)
    expect(page).not_to have_content :feature_a
    expect(page).not_to have_content :feature_b
  end
end
