Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :password_resets, only: [:new, :create, :edit, :update]
   # resources :users, only: [:show]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root "sessions#new"

end
