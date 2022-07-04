Rails.application.routes.draw do
  root 'searches#home'
  get '/result', to: 'searches#result'
  resources :users, only: [:show, :edit, :update]
  resources :schools
end
