Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :posts
  resources :profiles

  root 'posts#index'

  post 'friend_requests/:receiver_id', to: 'friendship#send_friend_request', as: 'send_friend_request'


  # sign out
  delete '/sign_out', to: 'devise/sessions#destroy', as: 'sign_out'

end
