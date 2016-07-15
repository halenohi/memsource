Rails.application.routes.draw do
  namespace :memberships do
    get 'acceptances/create'
  end

  namespace :circles do
    get 'comments/edit'
  end

  namespace :circles do
    get 'comments/new'
  end

  namespace :circles do
    get 'comments/create'
  end

  namespace :circles do
    get 'comments/update'
  end

  namespace :circles do
    get 'memberships/create'
  end

  get 'comments/destroy'

  get 'circles/index'

  get 'circles/show'

  get 'circles/new'

  get 'circles/create'

  get 'circles/edit'

  get 'circles/update'

  get 'circles/destroy'

  get 'users/new'

  get 'users/create'

  get 'users/destroy'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create, :destroy]

  resources :circles do
    resources :memberships, only: [:create] do
      resource :acceptance, only: [:create], module: :memberships
    end
    resources :comments, only: [:edit, :new, :create, :update], module: :circles
  end

  resources :comments, only: [:destroy]
end
