Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :restaurants do
      resources :reviews
      post ':user_id/bookmark_restaurant', to: 'bookmarks#bookmark_restaurant', as: :bookmark_restaurant
      post ':user_id/unbookmark_restaurant', to: 'bookmarks#unbookmark_restaurant', as: :unbookmark_restaurant
    end

    resources :profiles, only: [:update]
    resources :users, only: [:show]
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#create'
end
