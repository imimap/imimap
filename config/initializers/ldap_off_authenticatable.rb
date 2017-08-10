require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapOffAuthenticatable < Authenticatable

      def valid?
        params[:user] && (params[:user][:email] || params[:user][:password])
      end

      def authenticate!
        if params[:user]
          puts "WARNING - AUTHENTICATING WITH ANY PASSWORD"
          #when successfully connected to LDAP and user already exists
          user = User.find_by_email(params[:user][:email])
          if (user != nil)
            return success!(user)
          end

          # when no matching user exists
          @surname = "entry.sn.first"
          @givenname = "entry.givenname.first"
          @email = email
          @enrolment_number = "entry.uid.first"
          @student = Student.create({first_name: @givenname, last_name: @surname, enrolment_number: @enrolment_number, email: email})
          #TBD: this stores the ldap password in our database, and although encrypted, we shouldn't be doing this.
          @user = User.create({email: email, password: password, student_id: @student.id})
          puts @user.inspect
          puts @student.inspect
          return success!(@user)
          #  end
        end
      end

      def email
        return params[:user][:email]
      end

      def password
        params[:user][:password]
      end

    end
  end
end

Warden::Strategies.add(:ldap_off_authenticatable, Devise::Strategies::LdapOffAuthenticatable)
