Rails.application.routes.draw do

  mount ActionCable.server, at: '/cable'

  # API Routing for V1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy] do
        member do
          post :add_to_contact
          get :contacts
          get :check_contact
        end
        collection do
          get :search
        end
      end
      resources :user_sessions, only: [:create]
      resources :conversations do
        member do
          post :add_message
          get :messages
          get :last_message
        end
      end
      resources :messages
    end
  end

end
