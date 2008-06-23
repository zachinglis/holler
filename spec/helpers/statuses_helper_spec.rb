require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesHelper do
  include StatusesHelper
  
  describe "#today_tomorow_or_day" do
    it "should return the correct value for todays date" do
      today_tomorow_or_day(Time.now.utc).should eql("Today")
    end
    
    it "should return the correct value for yesterdays date" do
      today_tomorow_or_day(1.day.ago.utc).should eql("Yesterday")
    end
    
    it "should return the correct value for any other date" do
      today_tomorow_or_day(4.days.ago.utc).should eql(4.days.ago.strftime("%A"))
    end
  end

  describe "#user_class" do
    it "should return 'higlight' if user is the current_user" do
      user, current_user = users(:quentin), users(:quentin)
      user_class(user, current_user).should eql('highlight')
    end
    
    it "should return nothing if user is not the current_user" do
      user, current_user = users(:aaron), users(:quentin)
      user_class(user, current_user).should be_nil
    end
  end
end
