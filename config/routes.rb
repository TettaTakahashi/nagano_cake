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
  
  
 
  namespace :public do
    resources :items, only: [:index] 
    resources :customers, only: [:show, :edit, :update]
    get 'customers/confirm_withdraw'
  end
  
  namespace :admin do
    get 'homes/top'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
