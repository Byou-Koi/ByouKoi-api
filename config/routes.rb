Rails.application.routes.draw do
  #api
  namespace :api, default: {format: :json} do
    resources :users, only: [:create, :show, :update] do
      member do
        post 'check_lover'
      end
    end
    resources :sessions, only: [:create]
    resources :chats, only: [:index, :create]
  end
end
