Rails.application.routes.draw do
  get '/admin', to: 'admin#index', as: :admin

  resources :tickets do
    member do
      post 'add_conversation'
      get 'close'
      put 'assign'
    end
  end
  
  devise_for :users
  
  resources :users
  
  get '/download_history/:id', to: 'tickets#download_history', as: :download_history
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "tickets#index"
  
  namespace :api do 
    namespace :v1 do 
      resources :tickets, only: [:index, :create, :destroy, :update]
    end 
  end
  
end
