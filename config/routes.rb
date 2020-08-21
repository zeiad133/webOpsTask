# frozen_string_literal: true

Rails.application.routes.draw do
  root      'application#index'
  
  resources :application, only: [:index, :new, :create]
  
  namespace :api do
    post 'user_token' => 'user_token#create'
    post 'sign_up' => 'users#sign_up'

    get 'users/self' => 'users#self'
    resources :users
    resources :tags
    resources :posts
    resources :comments
  end
end
