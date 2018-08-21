# frozen_string_literal: true

require 'devise/strategies/authenticatable'
require 'ldap/ldaphtw_adapter'

def report_issue(message)
  @logger.warn(message)
  params[:ldap_status] = [] unless params[:ldap_status]
  params[:ldap_status] << message
end

def self.issues
  { ldap_env_missing:
    'LDAP configuration missing - set LDAP environment variable',
    ldap_could_not_connect:
    'LDAP: Could not connect to server',
    ldap_email_not_valid: "email couldn't be matched:",
    ldap_authentication_failed: 'Authentication failed' }
end

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
        @ldap_adapter ||= LDAPHTWAdapter.new(ldap_email)
      end

      def valid?
        ldap_adapter.valid && ldap_password
      end

      def authenticate!
        auth_successful = create(ldap_password).authenticate
        if auth_successful
          user = User.find_or_create_by(email: ldap_email)
          return success!(user)
        else
          message = 'ldap: no message'
          message = ldap_adapter.errors[0].join if ldap_adapter.errors.any?
          return fail!(message)
        end
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable,
                       Devise::Strategies::LdapAuthenticatable)
