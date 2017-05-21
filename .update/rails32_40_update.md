# Todos after update
- removed gem "date-input-rails" from gemfile.
- write tests for 	

      app/views/users/\_creation_form.html.erb
      f.date_field :birthday, :readonly => @user_creation_form.student_exists?


 # after tests are running

##  refactor LDAP
LDAP information is distributed over 2 files
 modified:   app/controllers/user_verifications_controller.rb
 modified:   app/models/ldap_authentication.rb

## Take care of asset gems!
