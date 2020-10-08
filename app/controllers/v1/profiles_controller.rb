class V1::ProfilesController < ApplicationController
    def update
        @profile = User.find(params[:id]).profile
        attach_avatar(params[:avatar]) if params[:avatar]
        update_settings(params[:settings]) if params[:settings]
        @profile.update(profile_params)
        head :no_content
    end



    private

    def profile_params
        params.permit(:first_name, :last_name)
    end

    def attach_avatar(image)
        @profile.avatar.attach(image)
        @uri = url_for(@profile.avatar)
        @profile.update(avatar_uri: @uri)
    end

    def update_settings(settings)
        settings = JSON.parse(settings)
        user = User.find(params[:id])
        user.settings(:all).facebook_avatar = settings['facebook_avatar']
        user.settings(:all).distance_unit = settings['distance_unit']
        user.save!
    end
end
