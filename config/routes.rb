Rails.application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/auth/failure', to: 'sessions#failure', via: [:get, :post]
  match '/auth', to: 'sessions#destroy', via: [:delete]

  scope :api, format: 'json' do
    resources :users, only: [:show] do
      collection do
        get :current
      end
    end

    resources :rooms, only: [:index, :create, :destroy] do
      collection do
        post :join
      end
      member do
        delete :left
      end
    end
  end
end
