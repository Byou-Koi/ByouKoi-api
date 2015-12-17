Rails.application.routes.draw do
  #api
  namespace :api, default: {format: :json} do
    resources :users, only: [:create, :show, :update]
    resources :sessions, only: [:create]
    resources :chats, only: :create
  end
end
