Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'

  get '/about' => 'public/homes#about'

  scope module: :public do
    resources:items, only: [:index, :show]
    get 'customers/my_page' => 'customers#show'
    patch 'customers/my_page' => 'customers#update'
    get 'customers/my_page/edit' => 'customers#edit'
    get 'customers/confilm' => 'customers#confilm'
    patch 'customers/withdraw' => 'customers#withdraw'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources:cart_items, only: [:index, :create, :update, :destroy]
    post 'orders/confirm'
    get 'orders/completed'
    resources:orders, only: [:new, :create, :index, :show]
    resources:shipping_address, only: [:index, :create, :edit, :update, :destroy]
  end

  get '/admin' => 'admin/homes#top'
  namespace :admin do
    resources:items, only: [:new, :index, :create, :show, :edit, :update]
    resources:genres, only: [:index, :create, :edit, :update]
    resources:customers, only: [:index, :show, :edit, :update]
    resources:orders, only: [:show, :update]
    resources:order_products, only: [:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
