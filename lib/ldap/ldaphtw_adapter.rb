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

  class << self
    attr_reader :netldap_mock
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
    netldap_mock || @netldap
  end

  def ldap_tls_options
    { verify_mode: OpenSSL::SSL::VERIFY_PEER,
      ca_file: './certs/CA-HTW-cert.pem' }
  end

  def ldap_auth_options(ldap_htw, ldap_username, ldap_password)
    { method: :simple,
      username: "CN=#{ldap_username},#{ldap_htw}",
      password: ldap_password }
  end

  def ldap_conf(ldap_host, ldap_port, ldap_htw, ldap_username, ldap_password)
    { host: ldap_host, port: ldap_port,
      encryption: {
        method: :simple_tls,
        tls_options: ldap_tls_options,
        # connect_timeout: 30,
        verbose: true
      },

      auth: ldap_auth_options(ldap_htw, ldap_username, ldap_password) }
  end

  def valid
    valid?
  end

  def valid?
    config && ldap_username
  end

  def log_error(host:, exception:)
    Rails.logger.error("-- ldap -- could not connect to host #{host} ")
    Rails.logger.error(exception.message)
  end

  def log_auth_failed(ldap_username:)
    Rails.logger
         .info("-- ldap -- authentication failed for #{ldap_username} ")
  end

  def authenticate
    begin
      success = netldap.bind
    rescue StandardError => e
      log_error(host: host, exception: e)
      return false
    end
    log_auth_failed(ldap_username: ldap_username) unless success
    success
  end

  def config
    if netldap_mock.nil?
      # ldap_host|ldap_port|ldap_htw
      ldapconfig = ENV['LDAP']
      Rails.logger.error("-- ldap -- ENV['LDAP'] missing ") unless ldapconfig
      @host, @port, @connectstring = ldapconfig&.split('/')
    else
      @host = 'some.host.de'
      @port = 4711
      @connectstring = 'xxxx'
    end
  end

  private

  def ldap_username
    return nil if email.nil?

    m = /\A(.*)@.*htw-berlin.de\z/.match(email.strip)
    return m[1] if m

    Rails.logger.info("-- ldap -- email not valid #{email} ")
    nil
  end
end
