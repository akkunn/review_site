Rails.application.routes.draw do
  root 'searches#home'
  get '/result', to: 'searches#result'
end
