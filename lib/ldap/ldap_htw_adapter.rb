# frozen_string_literal: true

require 'net/ldap'
require 'ldap/ldap_htw_adapter_helper'
# HTW Specific Adapter to LDAP
class LDAPHTWAdapter
  include LDAPHTWAdapterHelper
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
    config
    @ldap_password = ldap_password
    @netldap = Net::LDAP.new(ldap_conf(@host, @port, @connectstring,
                                       ldap_username(email), ldap_password))
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
    config && ldap_username(email)
  end

  def log_error(host:, exception:)
    Rails.logger.error("-- ldap -- could not connect to host #{host} ")
    Rails.logger.error(exception.message)
  end

  def log_auth_failed(ldap_username:)
    Rails.logger
         .info("-- ldap -- authentication failed for #{ldap_username} ")
  end

  def always_return_true
    if @always_return_true
      Rails.logger.warn('--LDAP-- SET TO ALWAYS AUTHENTICATE!!')
      true
    else
      false
    end
  end

  def authenticate
    return true if always_return_true
    return false if @ldap_password == ''
    begin
      success = netldap.bind
    rescue StandardError => e
      log_error(host: host, exception: e)
      return false
    end
    log_auth_failed(ldap_username: ldap_username(email)) unless success
    success
  end

  def config
    ldapconfig = ENV['LDAP'] # ldap_host|ldap_port|ldap_htw
    Rails.logger.error("-- ldap -- ENV['LDAP'] missing ") unless ldapconfig
    return mock_config unless netldap_mock.nil?

    return true if config_always_return_true(ldapconfig) || mock_config

    @host, @port, @connectstring = ldapconfig&.split('/')
    true
  end

  private

  def config_always_return_true(ldapconfig)
    @always_return_true = true if ldapconfig == 'ALWAYS_RETURN_TRUE'
  end

  def mock_config
    if netldap_mock.nil?
      false
    else
      @host = 'some.host.de'
      @port = 4711
      @connectstring = 'xxxx'
      true
    end
  end
end
