require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesHelper do
  include StatusesHelper
  
  describe ".today_tomorow_or_day" do
    it "should return the correct value for todays date" do
      today_tomorow_or_day(Time.today).should eql("Today")
    end
    
    it "should return the correct value for tomorows date" do
      today_tomorow_or_day(1.day.ago).should eql("Yesterday")
    end
    
    it "should return the correct value for any other date" do
      today_tomorow_or_day(4.days.ago).should eql(4.days.ago.strftime("%A"))
    end
  end

end
