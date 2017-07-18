require 'rails_helper'

RSpec.describe RegistrationState, :type => :model do
	let(:registration_state) { build :registration_state}

	context 'given a valid registration_state' do
		it 'can be saved with all required attributes present' do
			expect(registration_state.save).to be_truthy
		end
	end

end