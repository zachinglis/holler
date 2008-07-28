# == Schema Information
# Schema version: 20080622042242
#
# Table name: statuses
#
#  id         :integer(11)     not null, primary key
#  message    :text
#  user_id    :integer(11)
#  created_at :datetime
#  updated_at :datetime
#

class Status < ActiveRecord::Base
  acts_as_taggable
  # for to_json and to_xml
  serialize_fu :include => :user, :methods => [:user_name, :user_gravatar_url]
  
  belongs_to :user
  
  named_scope :today, lambda { { :conditions => ['created_at > ?', 1.day.ago.midnight] } }
  named_scope :since, lambda { |date| { :conditions => ['created_at > ?', date] } }
  
  validates_presence_of :message, :user_id
  validates_length_of   :message, :within => 1..200
  
  attr_protected :user_id
  
  alias_attribute :to_s, :message
  
  # this is actually a hack because of: http://rails.lighthouseapp.com/projects/8994/tickets/610-activerecord-to_json-doesn-t-invoke-include-s-to_json
  def user_name
    self.user.name
  end
  # this is actually a hack because of: http://rails.lighthouseapp.com/projects/8994/tickets/610-activerecord-to_json-doesn-t-invoke-include-s-to_json
  def user_gravatar_url
    self.user.gravatar_url
  end
  
end
