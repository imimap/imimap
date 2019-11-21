# frozen_string_literal: true

def migrate_email(student:, email:, enrolment_number:)
  if email.nil?
    save_email(student: student, enrolment_number: enrolment_number)
  elsif !email.match(/(s0\d{6}@htw-berlin.de)/)
    save_email_and_private_email(student: student,
                                 email: email,
                                 enrolment_number: enrolment_number)
  end
end

def save_email(student:, enrolment_number:)
  student.email = User.email_for(enrolment_number: enrolment_number)
  student.save!
end

def save_email_and_private_email(student:, email:, enrolment_number:)
  student.email = User.email_for(enrolment_number: enrolment_number)
  student.save!
  student.private_email = email
  student.save
end

# check students 399
namespace :imimap do
  desc 'differentiates htw and private email of student objects'
  task diff_htw_private_mail: :environment do
    students = Student.all
    puts "Going to migrate email addresses of #{students.count} students"
    students.each do |student|
      print '.'
      email = student.try(:email)
      enrolment_number = student.try(:enrolment_number)
      if enrolment_number.nil?
        print "student without enrolment number found, id #{student.id}"
        next
      end
      unless enrolment_number.match(/^(\d{6})$/) # cases like 357710 (TU)
        # remove leading 0 oder s0
        enrolment_number = enrolment_number.to_s.strip.gsub(/^s0|^0/, '')
        unless enrolment_number.match(/^(\d{6})$/)
          print "student without valid enrolment number found, id #{student.id}"
          next
        end
      end
      migrate_email(student: student,
                    email: email,
                    enrolment_number: enrolment_number)
    end
  end
end
