Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'chatrooms#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :messages, only: [:create]

  #this route will be listening for websocket requests to establish connection between client and server. When app is ran, it automatically establsihes a socket connection because of createconsumer.
  #default route is ws://localhost:3000/cable. which is the standard
  mount ActionCable.server, at: '/cable'
end
