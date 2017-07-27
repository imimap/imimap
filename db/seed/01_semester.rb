# ruby encoding: utf-8
Semester.destroy_all
for i in 0..5
  if i%2 == 0
    Semester.create(name: "WS #{Date.current.year-i}" , id:i)
  else  
    Semester.create(name: "SS #{Date.current.year-i}", id:i)
  end   
end