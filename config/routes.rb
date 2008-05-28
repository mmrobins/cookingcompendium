ActionController::Routing::Routes.draw do |map|

  map.resources :searches
  
  map.resources :menus do |menu|
    menu.resources :dishes
  end

  map.resources :users do |user|
    user.resources :recipes
  end
  
  map.resources :sessions
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.resources :purchase_options

  map.resources :foods, :collection => { :finder => :post} do |food|
    food.resources :purchase_options
    food.resources :food_conversions  
  end

  map.resources :recipes, :member => { :printable => :get, :edit_basics => :get } do |recipe|
    recipe.resources :ingredients, :collection => { :auto_complete_for_food_name => :post },
                                   :member => { :move => :put,
                                                :add_new_conversion_to_display => :put }
    recipe.resources :photos
    recipe.resources :comments  
  end
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.home '', :controller => "recipes"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
