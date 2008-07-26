# == Schema Information
# Schema version: 20080622042242
#
# Table name: users
#
#  id                        :integer(11)     not null, primary key
#  login                     :string(40)
#  name                      :string(100)     default("")
#  email                     :string(100)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  activation_code           :string(40)
#  activated_at              :datetime
#  state                     :string(255)     default("passive")
#  deleted_at                :datetime
#

require 'digest/sha1'

class User < ActiveRecord::Base
  # for to_json and to_xml
  serialize_fu :methods => :gravatar_url 
  
  has_many  :statuses, :dependent => :nullify
  has_one   :current_status, :class_name => "Status", :order => "created_at", :dependent => :nullify
  
  alias_attribute :to_s, :name

# Restful Authentication

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::StatefulRoles

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login,    :case_sensitive => false
  validates_format_of       :login,    :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD

  validates_format_of       :name,     :with => RE_NAME_OK,  :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => {:login => login} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  # Return the gravatar URL - ugly C&P from gravatar plugin - but the plugin is for ActionView only
  def gravatar_url(options={})
    email_hash = Digest::MD5.hexdigest(email)
    options = GravatarHelper::DEFAULT_OPTIONS.merge(options)
    options[:default] = CGI::escape(options[:default]) unless options[:default].nil?
    returning "http://www.gravatar.com/avatar.php?gravatar_id=#{email_hash}" do |url| 
      [:rating, :size, :default].each do |opt|
        unless options[opt].nil?
          value = options[opt]
          url << "&#{opt}=#{value}" 
        end
      end
    end
  end
  
protected
  
  def make_activation_code
      self.deleted_at = nil
      self.activation_code = self.class.make_token
  end

end
