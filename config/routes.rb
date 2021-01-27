Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'requests#new'

  resources :requests, only: %i[new create]
end
