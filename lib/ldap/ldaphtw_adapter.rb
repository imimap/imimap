# frozen_string_literal: true

require 'net/ldap'
# HTW Specific Adapter to LDAP
class LDAPHTWAdapter
  attr_accessor :email, :host, :port, :connectstring, :errors

  def initialize(email:)
    @email = email
    @errors = []
  end
  def valid
    valid?
  end
  def valid?
    config && ldap_username
  end

  def create(ldap_password:)
    ldap_host, ldap_port, ldap_htw = config
    @netldap = Net::LDAP.new(ldap_conf(ldap_host, ldap_port, ldap_htw,
                                       ldap_username, ldap_password))
    self
  end

  def ldap_conf(ldap_host, ldap_port, ldap_htw, ldap_username, ldap_password)
    { host: ldap_host, port: ldap_port,
      encryption: { method: :simple_tls,
                    verify_mode: OpenSSL::SSL::VERIFY_NONE },
      auth: {
        method: :simple,
        username: "CN=#{ldap_username},#{ldap_htw}",
        password: ldap_password
      } }
  end

  def authenticate
    begin
      success = @netldap.bind
    rescue StandardError
      report_issue(:ldap_could_not_connect, host)
      return false
    end
    report_issue(:ldap_authentication_failed) unless success
    success
  end

  def config
    # ldap_host|ldap_port|ldap_htw
    ldapconfig = ENV['LDAP']
    report_issue(:ldap_env_missing) unless ldapconfig
    @host, @port, @connectstring = ldapconfig&.split('|')
  end

  private

  def report_issue(key, info = '')
    @errors << [key, info]
  end

  def ldap_username
    m = /\A(.*)@.*htw-berlin.de\z/.match(email)
    return m[1] if m
    report_issue(:ldap_email_not_valid, email)
    nil
  end
end
