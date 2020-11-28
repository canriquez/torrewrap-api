require 'rails_helper'

RSpec.describe "Assets", type: :request do

    describe 'POST /img_upload' do

        let!(:valid_upload_request) do 
        {
            auth: 1,
            type: 'image',
            payload: 'payload'
        }.to_json
        end

        context 'when valid request' do
            before {post '/img_upload', params: valid_upload_request}

            it 'creates a new asset record with status 200 response' do
                expect(response).to have_http_status(200)
            end
        end
    end

end
