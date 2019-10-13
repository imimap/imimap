# frozen_string_literal: true

require 'rails_helper'
require_relative './dummy_internship'

RSpec.describe InternshipDuration, type: :model do
  describe 'sets end_date' do
    it 'to the next monday if it was a friday' do
      id =
        InternshipDummy.new(
          Date.new(2017, 10, 9),
          Date.new(2017, 10, 13)
        )
      duration = InternshipDuration.new(id)
      expect(duration.end_date).to eq(
        Date.new(2017, 10, 16)
      )
    end
    it 'to actual date for other weekdays than friday' do
      id =
        InternshipDummy.new(
          Date.new(2017, 10, 9),
          Date.new(2017, 10, 12)
        )
      duration = InternshipDuration.new(id)
      expect(duration.end_date).to eq(
        Date.new(2017, 10, 12)
      )
    end
  end
end
