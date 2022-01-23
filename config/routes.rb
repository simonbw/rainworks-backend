Rails.application.routes.draw do
  namespace :admin do
    resources :rainworks do
      get :approve, on: :member
      get :reject, on: :member
      get :expire, on: :member
    end
    resources :devices
    resources :reports

    root to: 'rainworks#index'
  end
  namespace :api do
    resources :devices, only: [:update], param: :device_uuid
    resources :submissions, only: [:index, :create, :update, :destroy] do 
      get :finalize, on: :member
      put :expire, on: :member
      get :improve, on: :member
    end
    resources :rainworks, only: [:index, :show]
    resources :reports, only: [:index, :create]
  end
end
