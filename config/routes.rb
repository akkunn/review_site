Rails.application.routes.draw do
  # get 'users/show'
  # get 'users/edit'
  root 'searches#home'
  get '/result', to: 'searches#result'
  resources :users, only: [:show, :edit]
end
