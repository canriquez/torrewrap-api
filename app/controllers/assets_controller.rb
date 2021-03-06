class AssetsController < ApplicationController
    before_action :check_cloud_config
    before_action :check_auth, only: %i[asset_upload asset_save asset_delete refresh]

    def asset_upload
        puts 'checking asset_params'
        p asset_params
        if asset_params[:asset_type] == 'image'
            url = uploadImageToCloudinary(asset_params[:payload], @user)
        elsif asset_params[:asset_type] == 'video'
            url = uploadVideoToCloudinary(asset_params[:payload], @user)
        else
            json_response ({
                error: 'Wrong Asset Type.'
            })
        end

        @asset = Asset.new(user: @user, asset_type: asset_params[:asset_type], cloud_url: url)
        puts 'Checking Save'
        puts '--> User:'
        p @user
        @asset.save
        p @asset.errors.messages
        if @asset.valid? 
            #update_user_profile_asset
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


    def asset_save
        if save_params[:asset_type] == 'image'
            url = saveImageToCloudinary(@user)
            @user.update(picture_thumbnail: url)
            response = {
                message: 'Asset saved successfully.',
                picture_thumbnail: @user.picture_thumbnail
            }
        elsif save_params[:asset_type] == 'video'
            url = saveVideoToCloudinary(@user)
            #Replaces .mkv to .mp4 extension if required in cloud file.
            url.gsub!(/\.mkv\b/, ".mp4") if url.include?('.mkv')
            @user.update(video_url:url)
            response = {
                message: 'Asset saved successfully.',
                video_url: @user.video_url
            }
        else
            response = {
                error: 'Wrong Asset Type.'
            }
        end
        json_response(response)
    end

    def asset_delete
        if save_params[:asset_type] == 'image'
            @user.update(picture_thumbnail: save_params[:cloud_url])
            response = {
                message: 'Asset deleted successfully.',
                picture_thumbnail: @user.picture_thumbnail
            }
        elsif save_params[:asset_type] == 'video'
            @user.update(video_url:save_params[:cloud_url])
            response = {
                message: 'Asset deleted successfully.',
                video_url: @user.video_url
            }
        else
            response = {
                error: 'Wrong Asset Type.'
            }
        end
        json_response(response)
    end

    def refresh
            json_response({
                            user_id: @user.id,
                            user_name: @user.name,
                            picture_thumbnail: @user.picture_thumbnail,
                            video_url: @user.video_url,
                            public_id: @user.public_id,
                            torre_data: @user.json_response,
                            created_at: @user.created_at,
                            updated_at: @user.updated_at
                          })
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

    def save_params
        params.permit(
            :user,
            :auth,
            :asset_type,
            :cloud_url,
        )
    end
    
    def update_user_profile_asset
        @user.update(picture_thumbnail: @asset.cloud_url) if asset_params[:asset_type] == 'image'
        #@user.update(video_url: @asset.cloud_url) if asset_params[:asset_type] == 'video'
        @user.update(video_url: @asset.cloud_url) if asset_params[:asset_type] == 'video'
    end

    def check_auth
        puts 'checking params'
        p params
        json_response ({error: 'Authorization failed'}) if params[:user] != params[:auth]
        @user = User.find(params[:user])
        puts "@user after checking auth"
        p @user
        json_response ({error: 'Authentication failed'}) if !@user
    end

    def check_cloud_config
        render 'configuration_missing' if Cloudinary.config.api_key.blank?
    end
end
