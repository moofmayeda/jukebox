Rails.application.routes.draw do
  root to: 'songs#index'
  devise_for :users
  resources :users, only: [:show, :index]
  resources :songs
end
