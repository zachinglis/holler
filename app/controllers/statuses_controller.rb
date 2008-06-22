class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @statuses = Status.all
    
    respond_to do |wants|
      wants.html
    end
  end
end
