require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesController do

  describe "being accessed by an unregistered user" do
    it "should not be able to be accessed" do
      get :index
      response.should redirect_to(login_url)
    end
  end
  
  describe do
    before(:each) do
      login_as :quentin
    end
    
    it "should be allowed to be accessed" do
      get :index
      response.should be_success
    end
  end

end
