Rails.application.routes.draw do

  # API Routing for V1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :tokens, only: [:create]
      resources :conversations do
        member do
          post :add_message
        end
      end
      resources :messages
    end
  end

end
