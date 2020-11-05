Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index]
      resources :messages, only: [:create, :index]
      resources :channels, only: [:index, :create]
      resources :user_channels, only: [:create]
    end
  end
end
