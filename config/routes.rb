Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users
  resources :friendships, only: [:index], path: :friends
  resources :users do
    resources :users
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post '/invitation', to: 'users#invitation'
  
  put '/accept', to: 'users#accept'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
