require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable

      def valid?
        params[:user] && (params[:user][:email] || params[:user][:password])
      end

      def authenticate!
        if params[:user]
          ldap = Net::LDAP.new
          ldap.host = "141.45.146.101"
          ldap.port = 389
          ldap.auth  searchstring, password

          if ldap.bind
            #when succesfully connected to LDAP and user already exists
            user = User.find_by_email(params[:user][:email])
            if (user != nil)
              return success!(user)
            else
              # when succesfully connected to ldap but there are no user
              if ldap.open do |ldap|
                ldap.search( :base => searchstring) do |entry|
                  @surname = entry.sn
                  @givenname = entry.givenname
                  @email = entry.mail
                  @enrolment_number = entry.uid
                  @stud = Student.create({first_name: @givenname, last_name: @surname, enrolment_number: @enrolment_number, email: params[:user][:email]})
                  @user = User.create({email: email, password: password, student_id: @stud.id})
                  #password: password, password_confirmation: password
                end
                return success!(user)
              end
              end
            end
          else
            # if ldap connection failed
            return fail(:invalid_login)
          end
        end
      end

      def email
        return params[:user][:email]
      end

      def searchstring
        email = params[:user][:email]
        usrid = email.split('@').first
        return "uid="+ usrid +", ou=Users, o=f4, dc=htw-berlin, dc=de"
      end

      def password
        params[:user][:password]
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)