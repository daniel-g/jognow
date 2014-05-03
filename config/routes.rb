Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :time_entries, only: [:index, :create]
  resources :reports, only: :index
end
