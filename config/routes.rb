Rails.application.routes.draw do

  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  post '/logout', to: 'users#logout_user'
  
  namespace :admin do
    get '/dashboard', to: 'dashboard#index', as: 'user'
  end
  get 'admin/users/:user_id', to: 'admin/users#show', scope: 'admin', as: 'admin_user_dashboard'

  namespace :manager do
    get '/dashboard', to: 'dashboard#index', as: 'user'
  end
  get 'manager/users/:user_id', to: 'manager/users#show', scope: 'manager', as: 'manager_user_dashboard'
  
  get '/dashboard', to: 'users#show', as: 'user'
  get '/dashboard/movies', to: 'movies#index', as: 'movies'
  get '/dashboard/movies/:id', to: 'movies#show', as: 'movie'

  resources :viewing_parties, only: [:new, :create]
end
