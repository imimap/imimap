# frozen_string_literal: true

START_16_WEEKS = Semester.for_date(Date.new(2019, 10, 1)).sid

# calculates internship duration in weeks and returns a validation constant
# the symbols returned by validation are resolved via I18n for the views
class InternshipDuration
  attr_accessor :start_date, :end_date, :days, :weeks, :validation

  def initialize(internship)
    @semester = internship.semester
    initialize_validation(internship)
  end

  def initialize_validation(internship)
    if internship.start_date && internship.end_date
      @start_date = internship.start_date
      @end_date = adjust(internship.end_date)
      @days = @end_date - @start_date
      @weeks = (@days.to_f / 7).round(2)
      @validation = do_validation(@weeks)
    else
      @days = @weeks = 0
      @validation = :date_missing
    end
  end

  def do_validation(weeks)
    # also in js in app/views/internships/_form_internship.html.erb
    if weeks.negative?
      :negative
    elsif weeks < 4
      :too_short
    elsif weeks < required_weeks(@semester)
      :ok_for_part
    else
      :ok
    end
  end

  def invalid_durations
    %i[negative too_short]
  end

  private

  def required_weeks(semester)
    if semester.sid >= START_16_WEEKS
      16
    else
      19
    end
  end

  def adjust(day)
    if day.friday?
      day + 3
    elsif day.saturday?
      day + 2
    elsif day.sunday?
      day + 1
    else
      day
    end
  end
end
