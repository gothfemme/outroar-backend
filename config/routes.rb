Rails.application.routes.draw do
  resources :memberships
  resources :messages
  resources :conversations
  get 'current' => 'users#current'
  post 'user_token' => 'user_token#create'
  post 'splash' => 'users#splash'
  resources :users, only: [:create]

  mount ActionCable.server => '/cable'
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
