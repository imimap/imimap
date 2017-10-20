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

  context "for an internship with 2 weeks" do
    before :each do
      id = InternshipDummy.new(Date.new(2017,10,9), Date.new(2017,10,20))
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(2)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:too_short)
    end
  end

  context "for an internship with 7 weeks" do
    before :each do
      id = InternshipDummy.new(Date.new(2017,10,2), Date.new(2017,11,17))
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(7)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:ok_for_part)
    end
  end

  context "for an internship with exactly 19 weeks" do
    before :each do
      id = InternshipDummy.new(Date.new(2017,10,2), Date.new(2018,2,9))
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(19)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:ok)
    end
  end

  context "for an internship with more than 19 weeks" do
    before :each do
      id = InternshipDummy.new(Date.new(2017,10,2), Date.new(2018,3,7))
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(22.285714285714285)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:ok)
    end
  end

  context "for an internship without an end_date" do
    before :each do
      id = InternshipDummy.new(Date.new(2017,10,2), nil)
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(0)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:date_missing)
    end
  end

  context "for an internship without an start_date" do
    before :each do
      id = InternshipDummy.new(nil, Date.new(2017,10,2))
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(0)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:date_missing)
    end
  end

  context "for an internship without any dates" do
    before :each do
      id = InternshipDummy.new(nil, nil)
      @duration = InternshipDuration.new(id)
    end
    it "weeks are computed correctly" do
      expect(@duration.weeks).to eq(0)
    end
    it "validation marker is set correctly" do
      expect(@duration.validation).to eq(:date_missing)
    end
  end


#  row ('weekCount') {ad.duration.weeks}
#  row ('weekValidation') {ad.duration.weekValidationActAdm}
end
