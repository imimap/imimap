class LdapAuthentication
  require 'net/ldap'
  # TBD40: move this into rails configuration http://guides.rubyonrails.org/configuring.html#custom-configuration
  @@host = "141.45.146.101"
  @@port = 389
  attr_reader :host, :port, :username, :password
  attr_accessor :ldap

  def self.configure(options = {})
    @@mode = options[:mode] # test
  end

  def initialize(username, password)
    @host = host
    @port = port
    @username = username
    @password = password
    establish_connection
  end
  def in_test_mode
    begin
       # TBD40: move this into rails configuration http://guides.rubyonrails.org/configuring.html#custom-configuration
      return true if @@mode == :test
      # :nocov:
      return true if Rails.configuration.imi-maps.ldap == :test
    rescue
      return false
    end
    return false
    # :nocov:
  end

  def establish_connection
    @ldap = Net::LDAP.new(host: @@host, port: @@port)
  end

  def authorized?
    begin
      return true if in_test_mode
      # thus, this is not tested automatically:
      # :nocov:
      ldap.bind(method: :simple, username: "uid=#{username}, ou=Users, o=f4, dc=htw-berlin, dc=de", password: password)
    rescue
      false
      # :nocov:
    end
  end
end
