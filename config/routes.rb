Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'welcome#index'
  resources :time_entries, only: [:index, :create]
  resources :reports, only: :index do
    get :time_entries, on: :collection
  end
end
