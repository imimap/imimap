# frozen_string_literal: true

# calculates internship duration in weeks and returns a validation constant
class InternshipDuration
  attr_accessor :start_date, :end_date, :days, :weeks, :validation

  def initialize(internship)
    if internship.start_date && internship.end_date
      @start_date = internship.start_date
      @end_date = adjust(internship.end_date)
      @days = @end_date - @start_date
      @weeks = @days.to_f / 7
      @validation = do_validation(@weeks)
    else
      @days = @weeks = 0
      @validation = :date_missing
    end
  end

  def do_validation(weeks)
    if weeks < 0
      :not_valid
    elsif weeks < 4
      :too_short
    elsif weeks < 19
      :ok_for_part
    else
      :ok
    end
  end

  # TBD this mapping needs to go to the translation,
  # depends on I18n working for ActiveAdmin

  def week_validation
    { too_short: 'notLongEnough',
      ok_for_part: 'partInternship',
      not_valid: 'notValid',
      ok: 'longEnough' }[validation]
  end

  def week_validation_active_admin
    { too_short: 'Intership is less than 4 weeks',
      ok_for_part: "if internship is a part internship it's valid",
      not_valid: 'Internship is not valid, please check again.',
      ok: 'Internship is long enough' }[validation]
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
