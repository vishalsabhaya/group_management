Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'authentication#login'
      resources :companies, only: [:create, :destroy] do
        resources :groups, only: [:index, :create]
        resources :users, only: [:create]
        post 'assign_group_user'
      end
    end
  end

end
