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
  
  belongs_to :user
  
  named_scope :today, lambda { { :conditions => ['created_at > ?', 1.day.ago.midnight] } }
  named_scope :since, lambda { |date| { :conditions => ['created_at > ?', date] } }
  
  alias_attribute :to_s, :message
end
