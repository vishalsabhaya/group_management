Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :companies, only: [:create] do
        resources :groups, only: [:create]
      end
    end
  end

end
