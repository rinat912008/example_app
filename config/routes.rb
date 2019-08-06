Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :client do
      namespace :v1 do
        resources :posts, only: %i[index create] do
          collection do
            get :index_jbuilder
            get :index_with_oj
            get :index_with_db
          end
        end
      end
    end

    namespace :admin do
      namespace :v1 do
        resources :users
      end
    end
  end

  resources :posts, only: :index
end
