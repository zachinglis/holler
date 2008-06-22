class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @users = User.all
    
    respond_to do |wants|
      wants.html
    end
  end
end
