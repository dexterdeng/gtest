Rails.application.routes.draw do

  devise_for :users

  resources :comments
  resources :posts
  resources :articles

  get "vote" => "votes#toggle"
  get 'users/:id' => 'users#show', as: :user

  root to: "home#index"

end
