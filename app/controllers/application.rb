# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # :secret => '7bc2289ad4e1567f96808f3d60e748e5'
  
  filter_parameter_logging :password
  
  include AuthenticatedSystem
  
  include RubyExtensions
  
end
