Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :time_entries, only: [:index, :create]
  resources :reports, only: :index do
    get :time_entries, on: :collection
  end
end
