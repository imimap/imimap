# frozen_string_literal: true

Semester.destroy_all
# this_year = Date.today.year
# ((this_year - 1)..year + 1).to_a.each do |year|
#   Semester.create(sid: year + 0.1)
#   Semester.create(sid: year + 0.2)
# end
semester = Semester.current
semester.save
semester.next.save
semester.previous.save
