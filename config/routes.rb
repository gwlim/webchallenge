WebChallenge::Application.routes.draw do
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

  ActiveAdmin.routes(self)

  devise_for :administrators, ActiveAdmin::Devise.config

  devise_for :students, :controllers => { :registrations => "registrations", :sessions => "sessions", :passwords => "passwords" , :confirmations => "confirmations" }

  authenticated :student do
    get '/student/home' => "students#home", :as => :student_root,:locale => /'en-US'|'zh-CN'|'zh-TW'/
    resources :questions, :path => "/student/questions/" ,:only=>[:update,:index]
    get '/student/result' => "students#result", :as => :student_result
    delete 'sign_out' => 'sessions#destroy', :as => :destroy_user_session, :via=> :delete
  end

  as :student do
    match '/cn' => 'sessions#new', :locale=>"zh-CN"
    match '/tw' => 'sessions#new', :locale=>"zh-TW"
    match '/en' => 'sessions#new', :locale=>"en-US"
    get 'students/activate' => "registrations#activate", :as => :student_activate
    get 'students/prizes' => "registrations#prizes", :as => :student_prizes
    get 'sign_in' => "sessions#new", :as => :new_student_session
    post 'sign_in' => 'sessions#create', :as => :student_session
  end

  root :to => redirect("/sign_in?locale=en-US")

end
