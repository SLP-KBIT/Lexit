Rails.application.routes.draw do
  root to: "top#index"

  devise_for :users
  resources :seminar_projects
  resources :entries
end
