# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin index orientations' do
  before :each do
    sign_in create(:admin_user)
    @orientations = [create(:orientation),
                     create(:orientation1),
                     create(:orientation2)]
  end
  it 'shows orientation names' do
    visit admin_orientations_path
    @orientations.each do |orientation|
      expect(page).to have_content(orientation.name)
    end
  end
  it 'shows single orientation ' do
    orientation = @orientations[0]
    visit admin_orientation_path(locale: 'de', id: orientation.id )
    expect(page).to have_content(orientation.name)
  end
end
