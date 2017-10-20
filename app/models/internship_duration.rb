class InternshipDuration

  attr_accessor :start_date, :end_date, :days, :weeks, :validation

  def initialize(internship)
    if internship.start_date && internship.end_date
      @start_date = internship.start_date
      d = internship.end_date
      @end_date = d.friday? ? d+3 : d
      @days = @end_date - @start_date
      @weeks = @days.to_f/7
      @validation = do_validation(@weeks)
    else
      @days = @weeks = 0
      @validation = :date_missing
    end
  end

  def do_validation(weeks)
    case
      when weeks < 4
        :too_short
      when weeks < 19
        :ok_for_part
      else
        :ok
    end
  end

  #TBD this mapping needs to go to the translation, depends on I18n working for ActiveAdmin

  def weekValidation
    { too_short: "notLongEnough",
      ok_for_part: "partInternship",
      ok: "longEnough"}[validation]
  end

  def weekValidationActAdm
    {too_short: "Intership is less than 4 weeks",
       ok_for_part: "if internship is a part internship it's valid",
       ok: "Internship is long enough"}[validation]
  end

end
