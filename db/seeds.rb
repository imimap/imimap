# frozen_string_literal: true

puts 'seeding database'

Postponement.destroy_all
UserCanSeeCompany.destroy_all
User.destroy_all

u = User.new(email: 'test@htw-berlin.de',
             password: 'geheim12',
             password_confirmation: 'geheim12')
u.student = Student.first
u.save

User.create(email: 'admin@htw-berlin.de',
            password: 'geheim12',
            password_confirmation: 'geheim12', role: :admin)
User.create(email: 'prof@htw-berlin.de',
            password: 'geheim12',
            password_confirmation: 'geheim12', role: :prof)

Dir[File.join(Rails.root, 'db', 'seed', '*.rb')].sort.each { |seed| load seed }

# [Student.first, Student.last].each do |student|
#   create_user_for_student(student: student)
# end
