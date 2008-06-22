class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @statuses = Status.since(1.week.ago).find(:all, :order => "created_at DESC")
    new
    
    respond_to do |wants|
      wants.html  { @statuses = @statuses.group_by { |status| status.created_at.strftime("%j") } }
      wants.xml   { render :text => @statuses.to_xml }
    end
  end
  
  def new
    @status = Status.new
  end
  
  def create
    @status = Status.new(params[:status])
    @status.user_id = current_user.id
    @status.save!
  end
end
