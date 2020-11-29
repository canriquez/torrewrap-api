module Cloud
    def uploadImageToCloudinary(image,user)
        Cloudinary::Uploader.upload(image,
            :folder => (user.id).to_s,
            :public_id => (user.id).to_s+'-profile_image-draft')["url"]
    end

    def uploadVideoToCloudinary(video, user)
        Cloudinary::Uploader.upload(video, 
            :folder => (user.id).to_s,
            :public_id => (user.id).to_s+'-profile_video-draft', 
            :resource_type => :video)["url"]
    end

    def saveImageToCloudinary(user)
        Cloudinary::Uploader.destroy((user.id).to_s+'/'+(user.id).to_s+'-profile_image-final', 
            options={:resource_type => :image})
        Cloudinary::Uploader.rename((user.id).to_s+'/'+(user.id).to_s+'-profile_image-draft',
            (user.id).to_s+'/'+(user.id).to_s+'-profile_image-final', 
            options={:resource_type => :image, :overwrite => true})["url"]
    end

    def saveVideoToCloudinary(user)
        Cloudinary::Uploader.destroy((user.id).to_s+'/'+(user.id).to_s+'-profile_video-final', 
            options={:resource_type => :image})
        Cloudinary::Uploader.rename((user.id).to_s+'/'+(user.id).to_s+'-profile_video-draft',
            (user.id).to_s+'/'+(user.id).to_s+'-profile_video-final', 
            options={:resource_type => :image, :overwrite => true})["url"]
    end
end