Rails.application.routes.draw do
  root to: 'pages#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create, :destroy]

  resources :circles do
    resources :memberships, only: [:index, :create], module: :circles do
      resource :acceptance, only: [:create], module: :memberships
    end
    resources :comments, only: [:edit, :new, :create, :update], module: :circles
  end

  resources :comments, only: [:destroy]
end
