# frozen_string_literal: true

require 'rails_helper'

describe 'current internships:' do
  context 'a student' do
    it 'doesnt see the link in the main menu'
    it 'cannot see the list of internships'
  end
  context 'a prof' do
    it 'sees the link in the main menu'
    it 'can see the list of internships'
  end
  context 'an admin' do
    it 'sees the link in the main menu'
    it 'can see the list of internships'
  end
  context 'an employee in the examination office' do
    it 'sees the link in the main menu'
    it 'can see the list of internships'
  end
end
