class V1::CheckInsController < ApplicationController

    def checkin_restaurant
        
        @user = User.find(params[:user_id])
        @restaurant = Restaurant.find(params[:restaurant_id])
        @restaurant.checkin @user
        head :no_content
    end


end
