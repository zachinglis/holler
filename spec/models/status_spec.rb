require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Status do
  before(:each) do
    @status = Status.new
  end

  it "should be valid" do
    @status.should be_valid
  end
end
