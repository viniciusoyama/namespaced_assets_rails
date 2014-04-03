Rails.application.routes.draw do

  root 'application#index'

  namespace :admin do
    resources :users, only: [:index]
  end
end
