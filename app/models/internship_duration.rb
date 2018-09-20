# frozen_string_literal: true

# calculates internship duration in weeks and returns a validation constant
# the symbols returned by validation are resolved via I18n for the views
class InternshipDuration
  attr_accessor :start_date, :end_date, :days, :weeks, :validation

  def initialize(internship)
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
    if weeks.negative?
      :negative
    elsif weeks < 4
      :too_short
    elsif weeks < 19
      :ok_for_part
    else
      :ok
    end
  end

  private

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
