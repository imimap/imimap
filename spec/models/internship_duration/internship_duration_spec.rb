# frozen_string_literal: true

require 'rails_helper'
require_relative './dummy_internship'

RSpec.describe InternshipDuration, type: :model do
  @semester_old_stupo = Semester.for_date(Date.new(2019, 4, 1))
  @semester_new_stupo = Semester.for_date(Date.new(2020, 4, 1))

  TC = Struct.new(:message, :internship, :weeks, :validation)

  testcases = [
    TC.new('for an internship with 2 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 9),
             Date.new(2017, 10, 20),
             @semester_new_stupo
           ), 2, :too_short),
    TC.new('for an internship with 4 weeks till saturday',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2017, 10, 29),
             @semester_new_stupo
           ), 4, :ok_for_part),
    TC.new('for an internship with 4 weeks - 1 day',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2017, 10, 26),
             @semester_old_stupo
           ), 3.4285714285714284, :too_short),
    TC.new('for an internship with 4 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2017, 10, 30),
             @semester_old_stupo
           ), 4, :ok_for_part),
    TC.new('for an internship with 7 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2017, 11, 17),
             @semester_new_stupo
           ), 7, :ok_for_part),
    TC.new('for an internship with one day less than 19 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2018, 2, 8),
             @semester_old_stupo
           ), 18.428571428571427, :ok_for_part),
    TC.new('for an internship with exactly 19 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2018, 2, 9),
             @semester_old_stupo
           ), 19, :ok),
    TC.new('for an internship with more than 19 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2018, 3, 7),
             @semester_old_stupo
           ), 22.285714285714285, :ok),

    TC.new('for an internship with one day less than 16 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2018, 1, 18),
             @semester_new_stupo
           ), 15.43, :ok_for_part),
    TC.new('for an internship with exactly 16 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2018, 1, 19),
             @semester_new_stupo
           ), 16, :ok),
    TC.new('for an internship with more than 16 weeks',
           InternshipDummy.new(
             Date.new(2017, 10, 2),
             Date.new(2018, 1, 25),
             @semester_new_stupo
           ), 16.43, :ok),
    TC.new('for an internship without an end_date',
           InternshipDummy.new(
             Date.new(2017, 10, 2), nil,
             @semester_old_stupo
           ), 0, :date_missing),
    TC.new('for an internship without an start_date',
           InternshipDummy.new(nil,
                               Date.new(2017, 10, 2),
                               @semester_new_stupo), 0, :date_missing),
    TC.new('for an internship without any dates',
           InternshipDummy.new(nil, nil,
                               @semester_old_stupo), 0, :date_missing)
  ]

  testcases.each do |tc|
    context tc.message do
      before :each do
        @duration = InternshipDuration.new(tc.internship)
      end
      it 'weeks are computed correctly' do
        expect(@duration.weeks).to eq(tc.weeks.round(2))
      end
      it 'validation marker is set correctly' do
        expect(@duration.validation).to eq(tc.validation)
      end
    end
  end
end
