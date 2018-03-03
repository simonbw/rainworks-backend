Rails.application.routes.draw do
  namespace :api do
  end
  namespace :admin do
    resources :rainworks
    resources :devices
    resources :reports

    root to: 'rainworks#index'
  end
  namespace :api do
    resources :devices, only: [:create]
    resources :submissions, only: [:index, :create]
    resources :rainworks, only: [:index]
    resources :reports, only: [:create]
  end
end
