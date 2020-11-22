Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
        sessions: "api/v1/auth/sessions",
      }
      resources :template
      resources :temusing, only: [:update]
      namespace :all do
        resources :temusing, only: [:show, :update, :destroy]
      end
      namespace :draft do
        resources :temusing, only: [:show]
      end
      namespace :sent do
        resources :temusing, only: [:index]
      end
    end
  end
end
