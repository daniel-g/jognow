Rails.application.routes.draw do
  root to: 'times#show'
  resources :times
end
