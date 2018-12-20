# frozen_string_literal: true

Semester.destroy_all
(2009..Date.today.year+1).to_a.each do |year|
  Semester.create(sid: year + 0.1)
  Semester.create(sid: year + 0.2)
end
