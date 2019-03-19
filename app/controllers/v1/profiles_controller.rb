class V1::ProfilesController < ApplicationController
    def update
        
        @profile = Profile.find(params[:id])
        attach_avatar(params[:avatar])
        head :no_content
    end



    private

    def profile_params
        params.permit(:first_name, :last_name)
    end

    def attach_avatar(image)
        if image
            @profile.avatar.attach(image)
            @uri = url_for(@profile.avatar)
            @profile.update(avatar_uri: @uri)
        else
            @profile.update(profile_params)
        end
    end
end
