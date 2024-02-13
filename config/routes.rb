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
    resources :items, only: [:index, :show] 
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/confirm_withdraw'=> 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
    get 'items' => 'items#index'
    get 'items/:id' => 'items#show'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items
    post 'orders/check' => 'orders#check'
    resources :orders
    resources :shipping_addresses, only: [:index, :create]
    
  end
  
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    get 'genres' => 'genres#index'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get '/' => 'homes#top'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
