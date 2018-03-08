Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "sessions#new"
  
  get "/register", to: "users#new"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  
  resources :users, except: [:destroy, :index, :new] do
    resources :alerts
  end
end
