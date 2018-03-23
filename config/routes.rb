Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "sessions#new"
  
  get "/register", to: "users#new"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  
  
  # Forgot password flow
  get "/password/forgot", to: "passwords#forgot"
  get "/password/edit", to: "passwords#edit"
  post "/password/reset", to: "passwords#reset"
  post "/password/update", to: "passwords#update"
  
  resources :users, except: [:destroy, :index, :new, :show] do
    get :confirm # Used for email address confirmation
    get :approve # used for admin to approve a user
    
    resources :alerts do
      get :crawls # "/users/:username/alerts/crawls" - for json API only
    end
  end
end
