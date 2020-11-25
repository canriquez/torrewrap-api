require 'rails_helper'

RSpec.describe "Users", type: :request do

    #Signup Action testing
    describe 'POST /signup' do

        let!(:user) {create(:user)}
        let!(:user_password) {user.password}

        let!(:valid_signup) {attributes_for(:user, name: 'Pepe', password_confirmation: user_password)}
        let!(:invalid_signup) {attributes_for(:user, password: '')}

        context 'when valid request' do
            before { post '/signup', params: valid_signup}

            it 'creates a new user with status 200 response' do
                expect(response).to have_http_status(200)
            end

            it 'returns success' do
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
                expect(json['message']).to eq("Signup error")
            end

            it 'returns success' do
                expect(json['user_id']).to be_nil
            end

        end

    end

end
