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
          ldap = Net::LDAP.new(connect_timeout: 15 )
          ldap.host = Rails.configuration.x.ldapServerAddr
          ldap.port = Rails.configuration.x.ldapPort
          ldap.auth  searchstring, password

          begin
          if ldap.bind
            #when successfully connected to LDAP and user already exists
            user = User.find_by_email(params[:user][:email])
            if (user != nil)
              return success!(user)
            end

            # when successfully connected to ldap but no matching user exists
            if ldap.open do |ldap|
              ldap.search( :base => searchstring , :connect_timeout=> 5) do |entry|
                @surname = entry.sn.first
                @givenname = entry.givenname.first
                @email = entry.mail.first
                @enrolment_number = entry.uid.first
                #TBD Review: why is email from params used rather than the one read from ldap? also, method email not used
                @stud = Student.create({first_name: @givenname, last_name: @surname, enrolment_number: @enrolment_number, email: @email})
                #TBD Review: this stores the ldap password in our database, and although encrypted, we shouldn't be doing this.
                @user = User.create({email: email, password: password, student_id: @stud.id})
              end
              return success!(@user)
              end
            end
          else
          # if ldap connection failed
          # fail ohne ! would pass authentication to next strategy and activate
          # the db authentication
          # ALSO REMOVE ! in rescue clause below
          return fail!(ldap.get_operation_result.message)
          end

          rescue Errno::ECONNREFUSED, Net::LDAP::Error => e
            return fail!(e)
          end
        end
      end

      def searchstring
        email = params[:user][:email]
        usrid = email.split('@').first
        return "uid=#{usrid}, ou=Users, o=f4, dc=htw-berlin, dc=de"
      end

      def password
        params[:user][:password]
      end

    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)
