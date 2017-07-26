4.times do
  Semester.create!(
    name: Faker::Number.number(1),
    id: Faker::Number.number(1)
  )
end
# Semester.destroy_all
# for i in 0..5
#   if i%2 == 0
#     Semester.create(name: "WS #{Date.current.year-i}" , id:i)
#   else  
#     Semester.create(name: "SS #{Date.current.year-i}", id:i)
#   end   
# end