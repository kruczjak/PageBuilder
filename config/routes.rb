Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :builds, only: :show
    resources :projects do
      member do
        get :directory_tree
        post :regenerate
      end

      resource :settings, module: :projects
      resource :git, module: :projects do
        collection do
          post :commit
          post :push
          post :pull
          post :deploy
        end
      end
      resources :files, module: :projects do
        collection do
          get :show
          put :update
          delete :destroy
        end
      end
    end
    resource :user, only: :show
  end
end
