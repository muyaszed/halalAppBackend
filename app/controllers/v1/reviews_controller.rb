class V1::ReviewsController < ApplicationController
    def index
        @restaurant = Restaurant.find(params[:restaurant_id])
        @reviews = @restaurant.reviews.all
        json_response(@reviews)
    end

    def create
        @restaurant = Restaurant.find(params[:restaurant_id])
        @review = @restaurant.reviews.where(user_id: current_user.id).create!(review_params)
        
        
        json_response(@review, :created)
    end

    def show
        @restaurant = Restaurant.find(params[:restaurant_id])
        @review = @restaurant.reviews.find(params[:id])
        json_response(@review)
    end

    def update
        @restaurant = Restaurant.find(params[:restaurant_id])
        @review = @restaurant.reviews.find(params[:id])
        @review.update!(review_params)
        head :no_content
    end

    def destroy
        @restaurant = Restaurant.find(params[:restaurant_id])
        @review = @restaurant.reviews.find(params[:id])
        @review.destroy
        head :no_content
    end


    private

    def review_params
        params.permit(:comment)
    end
end
