# frozen_string_literal: true

# testing with dumps there will be problems with students 540 362 392 399 523
namespace :imimap do
  desc 'differentiates htw and private email of student objects'
  task diff_htw_private_mail: :environment do
    students = Student.all
    puts "Going to migrate email addresses of #{students.count} students"
    students.each do |student|
      print '.'
      email = student.try(:email)
      enrollment_number = student.try(:enrolment_number)
      if enrollment_number.nil?
        print "student without enrolment number found, id #{student.id}"
        next
      end
      unless enrollment_number.match(/^(\d{6})$/) # cases like 357710 (TU)
        # remove leading 0 oder s0
        enrollment_number = enrollment_number.to_s.strip.gsub(/^s0|^0/, '')
        unless enrollment_number.match(/^(\d{6})$/)
          print "student without valid enrolment number found, id #{student.id}"
          next
        end
      end
      if email.nil?
        student.email = 's0' + enrollment_number.to_s + '@htw-berlin.de'
        student.save!
      elsif email.match(/(s0\d{6}@htw-berlin.de)/)
        next
      else
        student.email = 's0' + enrollment_number.to_s + '@htw-berlin.de'
        student.save!
        student.private_email = email
        student.save
      end
    end
  end
end
