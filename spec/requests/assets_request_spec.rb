require 'rails_helper'

RSpec.describe "Assets", type: :request do

    # POST testing image upload
    describe 'POST /asset_upload' do
        let!(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures",   "cloudtest.jpg"), "image/jpg")}
        let!(:user) {create(:user)}
        let!(:user_id) {user.id}
        let!(:valid_upload_request) do 
        {
            user: user_id,
            auth: user_id,
            asset_type: 'image',
            payload: file
        }
        end
        context 'when valid request' do
            before {post '/asset_upload', params: valid_upload_request}

            it 'creates a new asset record with status 200 response' do
                p json
                expect(json['message']).to eq('Asset stored successfully.')
            end
        end
    end

    # Post saving the asset image into User profile
    describe 'POST /asset_save' do
        let!(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures",   "cloudtest.jpg"), "image/jpg")}
        let!(:user) {create(:user)}
        let!(:user_id) {user.id}
        let!(:img_url) {'http://test.com/image.jpg'}
        let!(:video_url) {'http://test.com/video.mp4'}

        let!(:valid_upload_request) do 
            {
                user: user_id,
                auth: user_id,
                asset_type: 'image',
                payload: file
            }
            end

        let!(:valid_upload_image_request) do 
            {
                cloud_url: img_url,
                user: user_id,
                auth: user_id,
                asset_type: 'image',
            }
        end
        let!(:valid_upload_video_request) do 
            {
                cloud_url: video_url,
                user: user_id,
                auth: user_id,
                asset_type: 'video',
            }
        end
        context 'when valid image request' do
            before {post '/asset_upload', params: valid_upload_request}
            before {post '/asset_save', params: valid_upload_image_request}

            it 'Updates user record with new cloud_url for image asset' do
                p json
                expect(json['message']).to eq('Asset stored successfully.')
                expect(json['picture_thumbnail']).to eq(img_url)
            end
        end
        context 'when valid video request' do
            before {post '/asset_save', params: valid_upload_video_request}

            it 'Updates user record with new cloud_url for video asset' do
                p json
                expect(json['message']).to eq('Asset stored successfully.')
                expect(json['video_url']).to eq(video_url)
            end
        end
    end
end
