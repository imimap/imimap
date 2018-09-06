# frozen_string_literal: true

require 'net/ldap'
# HTW Specific Adapter to LDAP
class LDAPHTWAdapter
  attr_accessor :email, :host, :port, :connectstring, :errors

  def initialize(email:)
    @email = email
  end

  @netldap_mock = nil
  def self.substitute_netldap(mock:)
    @netldap_mock = mock
  end
  def self.netldap_mock
    @netldap_mock
  end
  def netldap_mock
    self.class.netldap_mock
  end

  def create(ldap_password:)
    ldap_host, ldap_port, ldap_htw = config
    @netldap = Net::LDAP.new(ldap_conf(ldap_host, ldap_port, ldap_htw,
                                       ldap_username, ldap_password))
    self
  end

  def netldap
    self.netldap_mock || @netldap
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

  def valid
    valid?
  end

  def valid?
    config && ldap_username
  end

  def authenticate
    begin
      success = netldap.bind
    rescue StandardError
      Rails.logger.error("-- ldap -- coud not connect to host #{host} ")
      return false
    end
    Rails.logger.info("-- ldap -- authentication failed for #{ldap_username} ") unless success
    success
  end

  def config
    if netldap_mock.nil?
      # ldap_host|ldap_port|ldap_htw
      ldapconfig = ENV['LDAP']
      Rails.logger.error("-- ldap -- ENV['LDAP'] missing ") unless ldapconfig
      @host, @port, @connectstring = ldapconfig&.split('|')
    else
      @host, @port, @connectstring = 'some.host.de', 4711, 'xxxx'
    end
  end

  private

  def ldap_username
    m = /\A(.*)@.*htw-berlin.de\z/.match(email)
    return m[1] if m
    Rails.logger.info("-- ldap -- email not valid #{email} ")
    nil
  end
end
