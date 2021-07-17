Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # post "/api/v1/items", to: 'api/v1/items#create'
  namespace :api do
    namespace :v1 do
      # post "items", to: 'items#create'
      resources :items, only: [:create]
    end
  end
end
