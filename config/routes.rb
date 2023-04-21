Rails.application.routes.draw do

    # 顧客用
    # URL /customers/sign_in
    devise_for :customers, skip: [:passwords], controllers: {
      regstrations: 'public/registrations',
      sessions: 'public/sessions'
    }

    # 管理者用
    # URL /admin/sign_in
    devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: 'admin/sessions'
    }

  namespace :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources:items, only: [:index, :show]
    resources:customers, only: [:show, :edit, :update]
    get 'customers/confilm'
    patch 'customers/withdraw'
    resources:cart_items, only: [:index, :create, :update, :destroy]
    delete 'cart_items/destroy_all'
    resources:orders, only: [:new, :create, :index, :show]
    post 'orders/confirm'
    get 'orders/completed'
    resources:shipping_address, only: [:index, :create, :edit, :update, :destroy]
  end


  namespace :admin do
    root to: 'homes#top'
    resources:items, only: [:new, :index, :create, :show, :edit, :update]
    resources:genres, only: [:index, :create, :edit, :update]
    resources:customers, only: [:index, :show, :edit, :update]
    resources:orders, only: [:show, :update]
    resources:order_products, only: [:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
