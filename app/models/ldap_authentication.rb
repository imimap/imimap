# TBD: This is a hack and will/needs to be replaced by ldap/devise.
class LdapAuthentication
  require 'net/ldap'
  # TBD40: move this into rails configuration http://guides.rubyonrails.org/configuring.html#custom-configuration
  @@host = "141.45.146.101"
  @@port = 389
  @@mode = :ldap

  def self.configure(options = {})
    @@mode = options[:mode] # test
  end
  def self.mode
    @@mode
  end

  def self.authorized?(username,password)
    authorized = false
    if in_test_mode?
      authorized = @@mode != :test_fail
    else
      # thus, this is not tested automatically:
      # :nocov:
      begin
        ldap = Net::LDAP.new(host: @@host, port: @@port)
        puts "querying ldap..."
        authorized = ldap.bind(method: :simple, username: "uid=#{username}, ou=Users, o=f4, dc=htw-berlin, dc=de", password: password)
      rescue
        authorized = false
        # :nocov:
      end
    end
    authorized
  end

  def self.in_test_mode?
       # TBD40: move this into rails configuration http://guides.rubyonrails.org/configuring.html#custom-configuration
      return true if @@mode == :test || @@mode == :test_fail
      # :nocov:
      #return true if Rails.configuration.imi-maps.ldap == :test
      return false
    # :nocov:
  end
end
