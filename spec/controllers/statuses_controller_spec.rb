require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesController do
  fixtures :users

  describe "being accessed by an unregistered user" do
    it "should not be able to be accessed" do
      get :index
      response.should redirect_to(login_url)
    end
  end
  
  describe "logged in" do
    before(:each) do
      login_as :quentin
    end
    
    describe "#index" do
      it "should be allowed to be accessed" do
        get :index
        response.should be_success
      end
    
      it "should initalize a new status object" do
        get :index
        assigns(:status).should be_new_record
      end
    end

    describe "#new" do
      it "should initalize a new status object" do
        get :new
        assigns(:status).should_not be_nil
        assigns(:status).should be_new_record
        response.should be_success
      end      
    end
    
    describe "#create" do
      it "should create a new status" do
        lambda {
          post :create, :status => { :message => "Doing stuff" }
          response.should be_redirect
        }.should change { Status.count }
      end
      
      it "should assign the user" do
        post :create, :status => { :message => "Doing stuff" }
        assigns(:status).user.should_not be_nil
      end
    end
  end
    
end
