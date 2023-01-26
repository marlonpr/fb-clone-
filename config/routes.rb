Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]
  resources :profiles
  resources :comments, only: [:create, :destroy]
  resources :posts do
    resources :comments, only: [:create]
  end

  root 'posts#index'

  post 'likes/:post_id', to: 'likes#create', as: 'likes'

  post 'friend_requests/:receiver_id', to: 'friendship#send_friend_request', as: 'send_friend_request'
  patch 'friend_requests/:id/:status', to: 'friendship#accept_friend_request', as: 'accept_friend_request'
  get 'friend_requests', to: 'friendship#index', as: 'friend_request'
  get 'friends', to: 'friendship#friends', as: 'friends'
  delete 'friends/:id', to: 'friendship#remove_friend', as: 'remove_friend'
  delete 'index/:id', to: 'friendship#remove_request', as: 'remove_request'

  # sign out
  delete '/sign_out', to: 'devise/sessions#destroy', as: 'sign_out'
end
