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
  belongs_to :user
  
end
