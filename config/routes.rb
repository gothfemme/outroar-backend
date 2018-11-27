Rails.application.routes.draw do
  post 'favorites' => 'favorites#create'
  delete 'favorites' => 'favorites#destroy'
  resources :memberships
  resources :messages
  resources :conversations
  get 'current' => 'users#current'
  post 'user_token' => 'user_token#create'
  get 'splash' => 'users#splash'
  patch 'users' => 'users#update'
  resources :users, only: [:create]

  mount ActionCable.server => '/cable'
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
