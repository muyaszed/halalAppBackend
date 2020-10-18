Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :restaurants do
      post 'approve', on: :member
      resources :reviews
      post ':user_id/bookmark_restaurant', to: 'bookmarks#bookmark_restaurant', as: :bookmark_restaurant
      post ':user_id/unbookmark_restaurant', to: 'bookmarks#unbookmark_restaurant', as: :unbookmark_restaurant

      post ':user_id/checkin_restaurant', to: 'check_ins#checkin_restaurant', as: :checkin_restaurant
      post ':user_id/halal_verification', to: 'halal_verifications#verify_halal', as: :halal_verification
    end

    resources :profiles, only: [:update]
    resources :users, only: [:show, :update]
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#create'
  post 'auth/fb_login', to: 'facebook_authentication#create'
end
