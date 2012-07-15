Trenches::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  get "secret" => "home#secret", :as => "secret"

  resources :users do
    resources :projects do
      resources :stories
      resources :members
      resources :sprints
    end
  end
  resources :sessions

  match '/users/:username/projects/:project_id/stories/:id/start' => 'stories#start', :as => :start_story
  match '/users/:username/projects/:project_id/stories/:id/finish' => 'stories#finish', :as => :finish_story

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  match 'users/:username/projects/:id/backlog' => 'projects#backlog', :as => :project_backlog
  match 'users/:username/projects/:id/sprints' => 'projects#sprints', :as => :project_sprints
  match 'users/:username/projects/:project_id/sprint/:id/planning' => 'sprints#planning', :as => :sprint_planning

  match 'users/:username/projects/:project_id/sprints/:id/add_and_sort_stories' => 'sprints#add_and_sort_stories', :as => :add_and_sort_stories
  match 'users/:username/projects/:project_id/sprints/:id/remove_and_sort_stories' => 'sprints#remove_and_sort_stories', :as => :remove_and_sort_stories

  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
