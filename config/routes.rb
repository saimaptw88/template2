Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "temusing/update"
    end
  end
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
      }
      resources :template
      resources :temusing, only: [:update]
    end
  end
end
