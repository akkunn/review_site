Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'searches#home'
  get '/result', to: 'searches#result'
  get '/solved', to: 'questions#solved'
  resources :users, only: [:show, :edit, :update]
  resources :schools
  resources :reviews
  resources :questions
  resources :answers, only: [:create, :edit, :update, :destroy]
  resources :user_schools, only: [:destroy]
end
