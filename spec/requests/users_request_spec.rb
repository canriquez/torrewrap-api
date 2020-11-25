require 'rails_helper'

RSpec.describe "Users", type: :request do

    #Signup Action testing
    describe 'POST /signup' do

        let!(:valid_signup) {attributes_for(:user, public_id: 'canriquez', password: '12345', password_confirmation: '12345')}
        let!(:invalid_signup) {attributes_for(:user, public_id: 'heheheh', password: '')}

        context 'when valid request' do
            before { post '/signup', params: valid_signup}

            it 'creates a new user with status 200 response' do
                expect(response).to have_http_status(200)
            end

            it 'returns success' do
              p json
              expect(json['user_id']).not_to be_nil
            end

        end

        context 'when request is invalid' do
            before { post '/signup', params: invalid_signup}

            it 'creates a new user status 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns error response' do
                p json
                expect(json['message']).to eq("Person not found! in Torre.co. Please use a valid username.")
            end

            it 'returns success' do
                expect(json['user_id']).to be_nil
            end

        end

    end

end
