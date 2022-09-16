Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'searches#home'
  get '/result', to: 'searches#result'
  get '/solved', to: 'questions#solved'
  post 'favorite_review/:id', to: 'favorite_reviews#create', as: 'create_favorite_review'
  delete 'favorite_review/:id', to: 'favorite_reviews#destroy', as: 'destroy_favorite_review'
  resources :users, only: [:show, :edit, :update]
  resources :schools
  resources :reviews
  resources :questions
  resources :answers, only: [:create, :edit, :update, :destroy]
  resources :user_schools, only: [:destroy]
  resources :notifications, only: :index
end
