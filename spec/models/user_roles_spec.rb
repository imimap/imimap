# frozen_string_literal: true

#
require 'rails_helper'

describe 'User roles' do
  it 'has a list of valid roles' do
    expect(User::ROLES.size).to eq 4
  end
  it 'nonexistent roles cannot be assigned' do
    u = User.new
    expect {u.role = :no_role}.to raise_error(ArgumentError)
  end
  it 'saves role' do
    u = User.create(email: 'bla@blub.de',
                    password: 'geheim12',
                    password_confirmation: 'geheim12')
    expect(u.user?).to eq true
  end
end
