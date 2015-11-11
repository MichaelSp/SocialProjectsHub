Rails.application.routes.draw do
  get 'static_page/about'
  get 'static_page/imprint'
  get 'static_page/contact'
  get 'static_page/terms'
  get 'static_page/privacy'

  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'

  resources :categories
  resources :users, except: [:show]
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
