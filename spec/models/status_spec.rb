require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Status do
  fixtures :users
  
  before(:each) do
    @status = Status.new(:message => "Doing something")
    @status.user_id = users(:quentin).id
  end

  it "should be valid" do
    @status.should be_valid
  end
end
