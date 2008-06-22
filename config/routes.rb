ActionController::Routing::Routes.draw do |map|
  
# Named Routes

  map.register  '/register',  :controller => 'users',     :action => 'create'
  map.signup    '/signup',    :controller => 'users',     :action => 'new' 
  map.login     '/login',     :controller => 'sessions',  :action => 'new' 
  map.logout    '/logout',    :controller => 'sessions',  :action => 'destroy'
  

# Resources  
  map.resources :statuses
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete } 
  map.resource  :session

  map.root      :statuses

end
