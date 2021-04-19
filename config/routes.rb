Rails.application.routes.draw do

  get 'admin' => 'admin/homes#top'
  root :to => 'public/homes#top'
  get 'about' => 'public/homes#about'

  devise_for :admins, controllers: {
    sessions:      'admin_devises/sessions',
    passwords:     'admin_devises/passwords',
    registrations: 'admin_devises/registrations'
  }
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :update, :create, :destroy]do
      delete "all_destroy"
    end
    resources :orders, only: [:index, :show, :new, :create]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
end
