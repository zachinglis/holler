class StatusesController < ApplicationController
  before_filter :login_required
  
  def index
    @statuses = Status.all.group_by { |status| status.created_at.pretty_date }
    # .group_by(&:user)
    
    respond_to do |wants|
      wants.html
    end
  end
end
