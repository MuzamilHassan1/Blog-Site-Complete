Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to:'pages#about'
  #route for all articles CRUD operation
  resources :articles#, only: [:show,:index,:new,:create, :edit. :update, :destroy]
  #specifying user routes
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  #creating login route in session controller
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #routes for categories
  resources :categories, except: [:destroy]
end
