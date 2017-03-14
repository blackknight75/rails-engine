Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :invoices do
        get '/find_all', to: 'search#index'
        get 'find',      to: 'search#show'
        get 'random',    to: 'random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/find_all', to: 'search#index'
        get 'find',      to: 'search#show'
        get 'random',    to: 'random#show'
      end
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
    end
  end
end
