class V1::ProfilesController < ApplicationController
    def update
        byebug
        # @profile = Profile.find(params[:id])
        @profile = User.find(params[:id]).profile
        byebug
        attach_avatar(params[:avatar])
        head :no_content
    end



    private

    def profile_params
        params.permit(:first_name, :last_name)
    end

    def attach_avatar(image)
        byebug
        if image
            @profile.avatar.attach(image)
            @uri = @profile.avatar.service_url
            @profile.update(avatar_uri: @uri)
        else
            @profile.update(profile_params)
        end
    end
end
