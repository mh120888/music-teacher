MusicTeacherRails::Application.routes.draw do


  resources :users, only: [:new, :create, :show] do
    resources :contacts do
      resources :assignments
      resources :requests
    end
  end

  match '/users/:user_id/contacts/:id/student', to: "contacts#student", as: "student"
  match '/users/:user_id/contacts/:id/lesson_info', to: "contacts#lesson_info", as: "lesson_info"
  resources :sessions, only: [:new, :create, :destory]
  match '/login', to: 'sessions#new', via: 'get', as: 'login'
  match '/logout', to: 'sessions#destroy', via: 'delete', as: 'logout'
  resources :appointments
  root to: "dashboard#index"

  match '/lesson' => 'dashboard#lesson'
  match '/metronome' => 'modules#metronome'
  match '/students' => 'modules#students'

  match '/finances' => 'payment_profiles#index'
  match 'payment_profiles/connect' => 'payment_profiles#connect'
  resources :payment_profiles
  resources :payments

  match '/test' => 'test#index'
  match '/test_module' => 'test#module'
  match '/another_test_module' => 'test#another_module'

  match '/sounds/search' => 'sounds#search', :as => :sc_search
  match '/sounds/connected' => 'sounds#connected', :as => :sc_connected
  match '/sounds/play' => 'sounds#play', :as => :sc_play
  resources :sounds, :only => [:index]



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
