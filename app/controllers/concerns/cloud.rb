module Cloud
    def uploadImageToCloudinary(image)
        Cloudinary::Uploader.upload(image)["url"]
    end

    def uploadVideoToCloudinary(video)
        Cloudinary::Uploader.upload(video, :resource_type => :video)["url"]
    end
end