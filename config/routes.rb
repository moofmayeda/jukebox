Rails.application.routes.draw do
  root to: 'songs#index'
  resources :songs, except: [:edit, :update]
  devise_for :users
end
