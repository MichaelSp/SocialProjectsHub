Rails.application.routes.draw do
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'

  resources :categories
  resources :users
  resources :projects do
    collection do
      get :refugee
      get :community
      get :entrepreneur
      get :volunteer
    end
  end

  root 'projects#index'
end
