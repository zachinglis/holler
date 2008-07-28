class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @statuses = Status.since(1.week.ago).find(:all, :order => "created_at DESC")
    new
    
    respond_to do |wants|
      wants.html  { @statuses = @statuses.group_by { |status| status.created_at.strftime("%j") } }
      wants.xml   { render :xml => @statuses }
      wants.json  { render :json => @statuses }
    end
  end
  
  def tag
    @statuses = Status.find_tagged_with(params[:tags], :match_all => !params[:match_all].blank?)
    new
    
    respond_to do |wants|
      wants.html  { 
        @statuses = @statuses.group_by { |status| status.created_at.strftime("%j") }
        render :action => :index
      }
      wants.xml   { render :xml => @statuses }
      wants.json  { render :json => @statuses }
    end
  end
  
  def new
    @status = Status.new
  end
  
  def create
    @status = Status.new(params[:status])
    @status.user_id = current_user.id
    @status.save!
    respond_to do |wants|
      wants.html  { redirect_to root_url } 
      wants.xml  { render :xml => @status, :status => :created, :location => @status }
      wants.json { render :json => @status }
    end
  end
end
