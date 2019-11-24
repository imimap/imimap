# frozen_string_literal: true

# helper methods for LDAPHTWAdapter
module LDAPHTWAdapterHelper
  def ldap_username(email)
    return nil if email.nil?

    m = /\A(.*)@.*htw-berlin.de\z/.match(email.strip)
    return m[1] if m

    Rails.logger.info("-- ldap -- email not valid #{email} ")
    nil
  end
end
