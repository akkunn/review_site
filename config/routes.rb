Rails.application.routes.draw do
  devise_for :users
  root 'searches#home'
  get '/result', to: 'searches#result'
  resources :users, only: [:show, :edit, :update]
  resources :schools
  resources :reviews
  resources :questions
  resources :answers, only: [:create, :edit, :update, :destroy]
end
