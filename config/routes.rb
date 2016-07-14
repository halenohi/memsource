Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :destroy]

  resources :circles do
    resources :memberships, only: [:create] do
      resource :acceptance, only: [:create]
    end
    resources :comments, only: [:edit, :new, :create]
  end

  resources :comments, only: [:destroy]

  # comment
  # resources :comments#, :only => [:index, :destroy, :create, :edit, :show]

  # user
  # devise_for :users, skip: [:sessions]
  # get "/login" => "user_sessions#new", as: :new_user_session
  # post "/login" => "user_sessions#create"
  # get "/logout" => "user_sessions#destroy", as: :destroy_user_session

  # circle
  # resources :circles, :only => [:index, :show, :new, :create, :destroy, :edit, :update]
  # get "/circles" => "circles/sessions#inedx", as: :index_circle_session
  # get "/circles" => "circle/sessions#new", as: :new_circle_session
  # post "/circles" => "circle/sessions#create"
  # post "/circle" => "circle/id/membership#create"
  # post "/circle" => "circle/id/membership/id#new", as: :new_memberships_session
  # delete "/circle" => "circle/membership#destroy", as: :destroy_memberships_session

end
