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
        post :switch
        delete :left
      end
    end

    resources :playlists, controller: 'playlists', only: :none do
      member do
        post :next
      end
      resources :items, controller: 'playlist_items', only: [:index, :create, :destroy] do
        member do
          post :move_up
          post :move_down
        end
      end
    end
  end
end
