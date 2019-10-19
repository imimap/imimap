# frozen_string_literal: true

require 'devise/strategies/authenticatable'
require 'ldap/ldaphtw_adapter'

module Devise
  module Strategies
    # Implements Authentication against HTW FB4 Ldap.
    class LdapAuthenticatable < Authenticatable
      def ldap_email
        return nil if params.nil?

        params[:user][:email] if params && params[:user]
      end

      def ldap_password
        params[:user][:password] if params[:user]
      end

      def ldap_adapter
        @ldap_adapter ||= LDAPHTWAdapter.new(email: ldap_email)
      end

      def valid?
        ldap_adapter.valid && ldap_password
      end

      def authenticate!
        Rails.logger.info("--LDAP-- attempting auth. for #{ldap_email}")
        auth_successful = ldap_adapter
                          .create(ldap_password: ldap_password)
                          .authenticate
        if auth_successful
          user = User.find_or_create(email: ldap_email, password: ldap_password)
          return success!(user)
        else
          Rails.logger.info("--LDAP-- authentication failed for #{ldap_email}")
        end
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable,
                       Devise::Strategies::LdapAuthenticatable)
