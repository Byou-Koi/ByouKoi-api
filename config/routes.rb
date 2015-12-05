Rails.application.routes.draw do
  #api
  namespace :api, default: {format: :json} do
    resources :users, only: [:create]
    resources :sessions, only: [:create]
  end
end
