Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
      resources :template
      resources :templateusing do
        member do
          post "recreate"
        end
      end
    end
  end
  # namespace :api do
  #   scope :v1 do
  #     mount_devise_token_auth_for "User", at: "auth"
  #     # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #   end
  # end
  # namespace :api do
  #   namespace :v1 do
  #     get 'templateusing/index'
  #   end
  # end
end
