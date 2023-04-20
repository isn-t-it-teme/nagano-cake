Rails.application.routes.draw do
  namespace :admin do
    root to: 'homes#top'
  end
  namespace :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
  end
  # 顧客用
  # URL /customers/sign_in
  devise_for :customers, skip: [:passwords], controllers: {
    regstrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
