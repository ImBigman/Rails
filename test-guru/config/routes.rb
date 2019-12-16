Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root to: 'tests#index'

  get :signup, to: 'users#new'
  get :login, to: 'sessions#new'

  resource :users, only: :create
  resource :sessions, only: %i[create destroy]

  resources :tests do
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end
end
