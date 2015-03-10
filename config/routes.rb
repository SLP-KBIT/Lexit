Rails.application.routes.draw do
  root to: "top#index"

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
end
