Rails.application.routes.draw do
  root :to => 'public/homes#top'
  get 'admin' => 'admin/homes#top'
  get 'about' => 'public/homes#about'
  devise_for :admins, controllers: {
    sessions:      'admin_devises/sessions',
    passwords:     'admin_devises/passwords',
    registrations: 'admin_devises/registrations'
  }

   devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update] do
      member do
        get 'customer_orders'
      end
    end
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :customer do
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'quit'
        patch 'withdraw'
      end
    end
    resources :items, only: [:index, :show]
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
end
