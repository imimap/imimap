# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin edit user' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    @user = create(:user)
    @student1 = @user.student
    @student2 = create(:student2)
  end
  it 'changes associated student' do
    visit admin_user_path(id: @user)
    click_on t('active_admin.edit_model', model: User.model_name.human)
    expect(page).not_to have_content 'NoMethodError'
    expect(page).to have_content @student1.name
    expect(page).to have_content t('active_admin.edit_model',
                                   model: User.model_name.human)
    select @student2.name,
           from: 'Student'
    click_on t('formtastic.update', model: User.model_name.human)
    expect(page).to have_content @student2.name
    expect(page).not_to have_content @student1.name
  end
end
