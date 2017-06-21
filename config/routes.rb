Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :builds, only: :show
    resources :projects, only: %i(create index show) do
      member do
        get :directory_tree
        post :regenerate
      end

      resource :settings, module: :projects, only: %i(show update)
      resource :git, module: :projects, only: [] do
        collection do
          post :commit
          post :push
          post :pull
          post :deploy
        end
      end
      resources :files, module: :projects, only: %i(create show update destroy) do
        collection do
          get :show
          put :update
          delete :destroy
        end
      end
    end
  end
end
