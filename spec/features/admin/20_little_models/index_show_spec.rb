# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin small models' do
  @test_data = { 'orientation' => %i[orientation
                                     orientation1
                                     orientation2],
                 'reading_prof' => %i[reading_prof
                                      reading_prof1
                                      reading_prof2
                                      reading_prof3],
                 'programming_language' => %i[forth
                                              whitespace
                                              velato
                                              brainfuck
                                              piet] }

  @test_data.each do |model, factory_names|
    before :each do
      sign_in create(:admin_user)
    end
    it "shows all names on #{model} index" do
      instances = factory_names.map { |f| create(f) }
      path = send("admin_#{model}s_path")
      visit path
      instances.each do |instance|
        expect(page).to have_content(instance.name)
      end
    end
    it "#{model} show includes name" do
      instance = create(factory_names[0])
      path = send("admin_#{model}_path", locale: 'de', id: instance.id)
      visit path
      expect(page).to have_content(instance.name)
    end
  end
end
