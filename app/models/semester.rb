# frozen_string_literal: true

require 'semester_helper'

# The Semester the Internship is assigned to
class Semester < ApplicationRecord
  include SemesterHelper

  has_many :internships
  before_save :set_sid_or_name

  default_scope { order(sid: :desc) }

  def self.current
    Semester.for_date(Date.today)
  end

  def self.for_date(date)
    date = Date.iso8601(date) if date.instance_of?(String)
    sid = SemesterHelper.date2sid(date)
    s = Semester.where(sid: sid).first
    return s unless s.nil?

    Semester.create(sid: sid)
  end

  def previous
    Semester.for_date(start_day - 6.months)
  end

  def next
    Semester.for_date(start_day + 6.months)
  end

  def year
    sid2year(sid)
  end

  def set_sid_or_name
    self.sid = name2sid(name) if sid.nil? && !name.nil?
    self.name = sid2name(sid) if name.nil? && !sid.nil?
  end

  def start_day
    SemesterHelper.start_day_for(year, winter_or_summer)
  end

  def winter_or_summer
    SemesterHelper.winter_or_summer(sid)
  end
end
