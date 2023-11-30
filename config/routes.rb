Rails.application.routes.draw do
  devise_for :users
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  # get '/users/sign_out', to: 'devise/sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "groups#index"
  get '/splash', to: 'splash#index'
  resources :expenses, only: [:new, :create]
  resources :groups, only: [:index, :show, :new, :create]

  # get '*path', to: redirect('/'), via: :all, constraints: lambda { |req| !req.path.starts_with?('/rails/active_storage') }
end
