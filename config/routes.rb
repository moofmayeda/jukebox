Rails.application.routes.draw do
  root to: 'songs#index'
  resources :songs
  devise_for :users
  resources :users, only: [:show, :index]
end
