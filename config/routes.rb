Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :time_entries
  resources :reports
end
