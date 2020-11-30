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
                user: user_id,
                auth: user_id,
                asset_type: 'image',
            }
        end

        context 'when valid image request' do
            before {post '/asset_upload', params: valid_upload_request}
            before {post '/asset_save', params: valid_upload_image_request}

            it 'Updates user record with new cloud_url for image asset' do
                p json
                expect(json['message']).to eq('Asset saved successfully.')
                expect(json['picture_thumbnail']).not_to be(nil)
            end
        end
    end

    # Post delets the asset image into using default urls
    describe 'POST /asset_delete' do
        let!(:user) {create(:user)}
        let!(:user_id) {user.id}


        let!(:valid_delete_video_request) do 
            {
                user: user_id,
                auth: user_id,
                asset_type: 'video',
                cloud_url:'http://dummy'
            }
        end
        context 'when valid image request' do
            before {post '/asset_delete', params: valid_delete_video_request}

            it 'Updates user record with new cloud_url for image asset' do
                p json
                expect(json['message']).to eq('Asset deleted successfully.')
                expect(json['video_url']).to eq('http://dummy')
            end
        end
    end

    describe 'GET /refresh' do
        let!(:user) {create(:user)}
        let!(:user_id) {user.id}


        let!(:valid_request) do 
            {
                user: user_id,
                auth: user_id,
            }
        end
        context 'when valid image request' do
            before {get '/refresh', params: valid_request}

            it 'Updates user record with new cloud_url for image asset' do
                p json
                expect(json['user_id']).to eq(user_id)
            end
        end
    end
end
