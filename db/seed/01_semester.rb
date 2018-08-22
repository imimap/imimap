# frozen_string_literal: true

Semester.destroy_all
for i in 0..5
  if i.even?
    Semester.create(name: "WS #{Date.current.year - i}", id: i)
  else
    Semester.create(name: "SS #{Date.current.year - i}", id: i)
  end
end
