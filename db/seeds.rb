# encoding: UTF-8
puts "seeding database"

Dir[File.join(Rails.root, 'db', 'seed', '*.rb')].sort.each { |seed| load seed }

# AdminUser.create(:email => "admin@imimaps.de", :password => 'geheim123', :password_confirmation => 'geheim123')
# User.destroy_all
# User.create!(email: "test@imimaps.com", student_id: 1,  :password => 'foofoofoo123123', :password_confirmation => 'foofoofoo123123', )
# User.create(:email => "user@imimaps.de", :password => 'foofoofoo123123', :password_confirmation => 'foofoofoo123123', student_id: 1)
user = User.find_by(email: 's012345@htw-berlin.de')
user.destroy if user
u= User.new(email:"s012345@htw-berlin.de",password:"qwertzuiop12",password_confirmation:"qwertzuiop12")
u.student=Student.first
u.superuser=true
u.save
