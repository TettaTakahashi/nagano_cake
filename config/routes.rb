Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  root to: "homes#top"
  get 'homes/about'
  
  
 
  scope module: :public do
    resources :items, only: [:index] 
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/confirm_withdraw'=> 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
  end
  
  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :create]
    get 'genres' => 'genres#index'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
