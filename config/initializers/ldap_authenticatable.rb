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
        Rails.logger.info("-- ldap -- Attempting ldap authorization for #{ldap_email}")
        auth_successful = ldap_adapter.create(ldap_password: ldap_password).authenticate
        if auth_successful
          user = User.where(email: ldap_email).first
          unless user
            rpw = SecureRandom.urlsafe_base64(24, false)
            user = User.create(email: ldap_email, password: rpw, password_confirmation: rpw)
          end
          return success!(user)
        else
          message = 'ldap: auth not successfull'
          message = ldap_adapter.errors[0].join if ldap_adapter.errors.any?
          report_issue(message)
          return raise(message)
        end
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable,
                       Devise::Strategies::LdapAuthenticatable)
