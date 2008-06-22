class ChangeStateDefaultToBeActive < ActiveRecord::Migration
  def self.up
    change_table :users do |user|
      user.change :state, :string, :default => "active"
    end
  end

  def self.down
    change_table :users do |user|
      user.change :state, :string, :default => "pending"
    end    
  end
end
