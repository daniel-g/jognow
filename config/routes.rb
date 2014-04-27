Rails.application.routes.draw do
  root to: 'time_entries#show'
  resources :time_entries
end
