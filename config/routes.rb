Rails.application.routes.draw do
  namespace :admin do
    resources :rainworks

    root to: 'rainworks#index'
  end
  namespace :api do
    get '/active-rainworks', to: 'rainworks#active_rainworks'
    post '/submissions', to: 'rainworks#create'
    get '/submissions/:device_id', to: 'rainworks#list_submissions'
    post '/report', to: 'rainworks#create_report'
  end
end
