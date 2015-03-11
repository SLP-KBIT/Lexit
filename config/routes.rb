Rails.application.routes.draw do
  root to: 'top#index'

  devise_for :users
  resources :seminar_projects do
    member do
      post :determine
    end
  end
  resources :entries, only: %i(create destroy)
  resources :comments, only: %i(create destroy)
  resources :seminar_sessions
  resources :preparations
  get 'seminar_sessions/:id/download/:type' => 'seminar_sessions#download', as: 'seminar_session_download'
  get 'preparations/:id/list/' => 'preparations#edit_list', as: 'edit_preparation_list'
  post 'preparations/:id/list/' => 'preparations#update_list', as: 'update_preparation_list'
end
