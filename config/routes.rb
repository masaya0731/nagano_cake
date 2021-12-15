Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get "/about", to: "public/homes#about"

  namespace :public do
    resources :customers, only: [:show, :edit, :update]
    get "/customers/unsubscribe", to: "customers#unsubscribe"
    patch "/customers/withdraw", to: "customers#withdraw"
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show]
    get "/orders/check", to: "orders#check"
    get "/orders/finish", to: "orders#finish"
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete "/cart_items", to: "cart_items#destroy_all"
    resources :delivery_addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
   devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
   }

   namespace :admin do
     root to: "homes#top"
     resources :orders, only: [:show, :update]
     resources :order_details, only: [:update]
     resources :customers, only: [:index, :show, :edit, :update]
     resources :items, only: [:index, :new, :create, :show, :edit, :update]
     resources :genres, only: [:index, :create, :edit, :update]
   end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
