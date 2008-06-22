class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @statuses = Status.since(1.week.ago).find(:all, :order => "created_at DESC").group_by { |status| status.created_at.strftime("%j") }
    
    respond_to do |wants|
      wants.html
    end
  end
end
