Rails.application.routes.draw do
  devise_for :users
  resources :seminar_projects
end
