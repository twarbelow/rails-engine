Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # post "/api/v1/items", to: 'api/v1/items#create'
  namespace :api do
    namespace :v1 do

      get '/items/find', to: 'items#find'
      
      resources :items, only: [:create, :update, :destroy, :show]

      resources :merchants, only: [:show]
    end
  end
end
