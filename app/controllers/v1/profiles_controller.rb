class V1::ProfilesController < ApplicationController
    def update
        
        @profile = Profile.find(params[:id])
        attach_avatar
        head :no_content
    end



    private

    def profile_params
        params.permit(:first_name, :last_name)
    end

    def attach_avatar
        if params[:avatar]
            @profile.avatar.attach(params[:avatar])
            @uri = url_for(@profile.avatar)
            @profile.update(avatar_uri: @uri)
        else
            @profile.update(profile_params)
        end
    end
end
