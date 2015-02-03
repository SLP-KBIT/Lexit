Rails.application.routes.draw do
  namespace :projects do
    resources :initiates, only: %i(new show create delete)
    resources :plans, only: %i(new show create delete)
  end
end
