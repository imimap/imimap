# frozen_string_literal: true

Semester.destroy_all
(0..5).to_a.each do |i|
  if i.even?
    Semester.create(name: "WS #{Date.current.year - i}", id: i)
  else
    Semester.create(name: "SS #{Date.current.year - i}", id: i)
  end
end
