require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  root 'requests#new'

  resources :requests, only: %i[new create] do 
    collection do 
      get "confirm/:token" => "requests#confirm", as: :email_confirmation
      get "reconfirm/:token" => "requests#reconfirm", as: :reconfirmation
    end
  end
end
