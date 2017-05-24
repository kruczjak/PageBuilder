Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :builds, only: :show
    resources :projects
    resource :user, only: :show
  end
end
