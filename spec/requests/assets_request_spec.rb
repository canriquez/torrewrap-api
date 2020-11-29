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

end
