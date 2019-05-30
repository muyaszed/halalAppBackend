class V1::BookmarksController < ApplicationController

    def bookmark_restaurant
        
        @user = User.find(params[:user_id])
        @restaurant = Restaurant.find(params[:restaurant_id])
        @restaurant.bookmark @user
        head :no_content
    end

    def unbookmark_restaurant
        
        @user = User.find(params[:user_id])
        @restaurant = Restaurant.find(params[:restaurant_id])
        @restaurant.unbookmark @user
        head :no_content
    end

end
