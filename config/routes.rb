Rails.application.routes.draw do
  root 'top#index'

  devise_for :users
  namespace :projects do
    resources :initiates, only: %i(index new show create delete)
    resources :plans, only: %i(index new show create delete)
  end
end
