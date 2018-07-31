Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :articles

  get "vote" => "votes#toggle"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "articles#index"
  # home#index"
end
