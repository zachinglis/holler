class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @users = User.find(:all, :order => "name ASC")
    
    respond_to do |wants|
      wants.html
    end
  end
end
