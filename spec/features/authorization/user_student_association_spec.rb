# frozen_string_literal: true

require 'rails_helper'

describe 'Student login' do
  context 'first time - no user present' do
    before :each do
    end
    it 'user is created'
    it 'created user is associated with existing student object'
    it 'student object is created if not present'
  end

  context 'second time - user already present' do
    before :each do
    end
    it 'logs in and student info can be shown'
  end
end
