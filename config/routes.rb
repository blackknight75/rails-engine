Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
      end
      resources :merchants, only: [:index, :show] do
      end
    end
  end
end
