class V1::ProfilesController < ApplicationController
    def update
        @profile = Profile.find(params[:id])
        @profile.update(profile_params)
        head :no_content
    end

    private

    def profile_params
        params.permit(:avatar)
    end
end
