Rails.application.routes.draw do
  namespace :admin do
      resources :rainworks

      root to: "rainworks#index"
    end
  resources :rainworks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
