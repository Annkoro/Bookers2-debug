Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  devise_for :users
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
     # "あるユーザーがフォローしている人全員を表示させるためのルーティング"
    get :followings, on: :member
     # "あるユーザーをフォローしてくれている人全員（フォロワー一覧画面）をとってくるためのルーティング"
    get :followers, on: :member
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end