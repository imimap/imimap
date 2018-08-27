# frozen_string_literal: true

puts 'seeding database'

Dir[File.join(Rails.root, 'db', 'seed', '*.rb')].sort.each { |seed| load seed }

User.destroy_all
u = User.new(email: 'test@htw-berlin.de', password: 'geheim12', password_confirmation: 'geheim12')
u.student = Student.first
u.save

User.create(email: 'admin@htw-berlin.de', password: 'geheim12', password_confirmation: 'geheim12', role: :admin)
User.create(email: 'prof@htw-berlin.de', password: 'geheim12', password_confirmation: 'geheim12', role: :prof)

[Student.first, Student.last].each do |student|
  User.create(email: "s0#{student.enrolment_number}@student.htw-berlin.de",
              password: 'geheim12',
              password_confirmation: 'geheim12',
              role: :user,
              student: student)
  puts "created user for student #{student.enrolment_number}"
end
