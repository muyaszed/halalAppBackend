class V1::HalalVerificationsController < ApplicationController
  def verify_halal
    HalalVerification.create!(
      user_id: params[:user_id],
      restaurant_id: params[:restaurant_id],
      certificate: params[:certificate] ? params[:certificate] : false,
      confirmation: params[:confirmation] ? params[:confirmation]  : false,
      logo: params[:logo] ? params[:logo] : false,
    )
    head :no_content
  end
end
