# The IMI-Map Model

As the IMI-Map source code can be a bit overwhelming, it's best to
look at the main Model Classes/Resources first:

Internship
Student
Company
CompanyAddress
User

Internship belongs_to Student, Student has_many Internships
Internship belongs_to CompanyAddress
CompanyAddress has_many Internships
CompanyAddress belongs_to Company
Company has_many CompanyAddresses
Company has_many Internships through CompanyAddresses

User 1-1 Student (do all Students in the old db have users?)
Users are for logging in / devise



Student.all.map{|s| s.user}.select{|u| !u.nil?}.count
129
Student.all.map{|s| s.user}.select{|u| u.nil?}.count
=> 368
students_with_user = Student.all.select{|s| !s.user.nil?}


Halbwegs klarer Bezug
time = Student.all.select{|s| !s.user.nil?}.map{|s| s.updated_at}
irb(main):010:0> time.max
=> Thu, 22 Feb 2018 12:04:36 UTC +00:00
irb(main):011:0> time.min
=> Thu, 11 Jul 2013 17:06:23 UTC +00:00
irb(main):012:0>

ohne user:
irb(main):013:0> time.min
=> Thu, 11 Jul 2013 17:06:23 UTC +00:00
irb(main):014:0> time.max
=> Wed, 01 Aug 2018 09:55:05 UTC +00:00


## Model Migration on production server
Notes for the model migration

Model Migration: pulling out CompanyAddress out of Company such that
each Company can have Multiple Addresses.

There is a migration with 3001 year - needs to be executed after the
data migration tasks (rake -T imimap)


    rake -T imimap

    rails db:rollback
    should rollback this migration:

    == 30180827172427 RenameAddressFieldsInCompany: reverting =====================

    rake imimap:kleinen_admin       # make kleinen@htw-berlin.de admin
    rake imimap:move_address        # create an address object for each company
    rake imimap:update_internships  # associate Internships with company_address

    don't run the migration again! before running it, it should get a proper
    sequential number - or maybe even better do this in the version that
    will be deployed to production.

    then

    rails db:migrate

  ****  delete all users!
  ****  later: delete all adminusers!

    create a migration that removes the renamed attributes,
    as they are no longer needed.
