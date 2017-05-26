Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :builds, only: :show
    resources :projects do
      member { get :directory_tree }
    end
    resource :user, only: :show
  end
end
