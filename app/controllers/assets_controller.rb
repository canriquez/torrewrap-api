class AssetsController < ApplicationController
    before_action :check_cloud_config
    before_action :check_auth, only: %i[asset_upload]

    def asset_upload
        if asset_params[:asset_type] == 'image'
            url = uploadImageToCloudinary(asset_params[:payload])
        elsif asset_params[:asset_type] == 'video'
            url = uploadVideoToCloudinary(asset_params[:payload])
        else
            json_response ({
                error: 'Wrong Asset Type.'
            })
        end

        @asset = Asset.new(user: @user, asset_type: asset_params[:asset_type], cloud_url: url)
        @asset.save
        p @asset.errors.messages
        if @asset.valid? 
            update_user_profile_asset
            json_response ({
                message: 'Asset stored successfully.',
                asset: @asset
            })
        else
            json_response ({
                error: 'Failed to store asset.',
                message: @asset.errors.messages
            })
        end
    end


private

    def asset_params
        params.permit(
            :user,
            :auth,
            :asset_type,
            :payload,
        )
    end
    
    def update_user_profile_asset
        @user.update(picture_thumbnail: @asset.cloud_url) if asset_params[:asset_type] == 'image'
        @user.update(video_url: @asset.cloud_url) if asset_params[:asset_type] == 'video'
    end

    def check_auth
        json_response ({error: 'Authorization failed'}) if params[:user] != params[:auth]
        @user = User.find(params[:user])
        puts "checking auth"
        p @user
        json_response ({error: 'Authentication failed'}) if !@user
    end

    def check_cloud_config
        render 'configuration_missing' if Cloudinary.config.api_key.blank?
    end
end
