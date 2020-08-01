# frozen_string_literal: true

# helper methods for the conversion of SS 13 2013.1 etc.
module SemesterHelper
  SUMMER = 'SS'
  WINTER = 'WS'
  SEM_NO = { 'SS': 1, 'WS': 2 }.freeze
  NO_SEM = SEM_NO.invert

  def self.start_day_for(a_year, winter_or_summer)
    if winter_or_summer == SUMMER
      Date.new(a_year, 4, 1)
    else
      Date.new(a_year, 10, 1)
    end
  end

  def self.date2sid(date)
    year = date.year
    return (year - 1).to_f + 0.2 if date < start_day_for(year, SUMMER)

    return year.to_f + 0.1 if date < start_day_for(year, WINTER)

    year.to_f + 0.2
  end

  def sid2year(sid)
    ((sid * 10).to_i / 10)
  end

  def sid2yearname(a_sid, winter)
    year2 = sid2year(a_sid) % 100
    year_s =  year2.to_s.rjust(2, '0')
    year_s += '/' + (year2 + 1).to_s.rjust(2, '0') if winter
    year_s
  end

  def name2sid(name)
    m = %r{(WS|SS) (\d\d)(/\d\d)?}.match(name)
    raise "couldn't match #{name}" unless m

    year = 2000 + m[2].to_i
    sow_code = SEM_NO[m[1].to_sym]
    raise "invalid semester marker in #{name}" unless sow_code

    year + sow_code.to_f / 10
  end

  def sid2name(a_sid)
    s_o_w = SemesterHelper.winter_or_summer(a_sid)
    "#{s_o_w} #{sid2yearname(sid, s_o_w == 'WS')}"
  end

  def self.winter_or_summer(a_sid)
    sow_code = (a_sid * 10).to_i % 10
    NO_SEM[sow_code].to_s
  end
end
