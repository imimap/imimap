# frozen_string_literal: true

#
require 'rails_helper'

RSpec.describe InternshipDuration, :type => :model do
  InternshipDummy = Struct.new(:start_date,:end_date)

  describe "sets end_date" do
    it 'to the next monday if it was a friday' do
      id = InternshipDummy.new(Date.new(2017,10,9), Date.new(2017,10,13))
      duration = InternshipDuration.new(id)
      expect(duration.end_date).to eq(Date.new(2017,10,16))
    end
    it 'to actual date for other weekdays than friday' do
      id = InternshipDummy.new(Date.new(2017,10,9), Date.new(2017,10,12))
      duration = InternshipDuration.new(id)
      expect(duration.end_date).to eq(Date.new(2017,10,12))
    end
  end
  TC = Struct.new(:message,:internship,:weeks,:validation)

  testcases = [
    TC.new("for an internship with 2 weeks", InternshipDummy.new(Date.new(2017,10,9), Date.new(2017,10,20)),2,:too_short),
    TC.new("for an internship with 4 weeks till saturday",InternshipDummy.new(Date.new(2017,10,2), Date.new(2017,10,29)),4,:ok_for_part),
    TC.new("for an internship with 4 weeks - 1 day",InternshipDummy.new(Date.new(2017,10,2), Date.new(2017,10,26)),3.4285714285714284,:too_short),
    TC.new("for an internship with 4 weeks",InternshipDummy.new(Date.new(2017,10,2), Date.new(2017,10,30)),4,:ok_for_part),
    TC.new("for an internship with 7 weeks",InternshipDummy.new(Date.new(2017,10,2), Date.new(2017,11,17)),7,:ok_for_part),
    TC.new("for an internship with one day less than 19 weeks",InternshipDummy.new(Date.new(2017,10,2), Date.new(2018,2,8)),18.428571428571427,:ok_for_part),
    TC.new("for an internship with exactly 19 weeks",InternshipDummy.new(Date.new(2017,10,2), Date.new(2018,2,9)),19,:ok),
    TC.new("for an internship with more than 19 weeks",InternshipDummy.new(Date.new(2017,10,2), Date.new(2018,3,7)),22.285714285714285,:ok),
    TC.new("for an internship without an end_date",InternshipDummy.new(Date.new(2017,10,2), nil),0,:date_missing),
    TC.new("for an internship without an start_date",InternshipDummy.new(nil, Date.new(2017,10,2)),0,:date_missing),
    TC.new("for an internship without any dates",InternshipDummy.new(nil, nil),0,:date_missing)
  ]

  testcases.each do | tc |
    context tc.message do
      before :each do
        @duration = InternshipDuration.new(tc.internship)
      end
      it "weeks are computed correctly" do
        expect(@duration.weeks).to eq(tc.weeks)
      end
      it "validation marker is set correctly" do
        expect(@duration.validation).to eq(tc.validation)
      end
    end
  end

end
