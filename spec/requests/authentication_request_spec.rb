require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  # login action testing
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let!(:user_id) { user.id }
    let!(:user_password) { user.password }

    let!(:good_credentials) { FactoryBot.attributes_for(:user) }
    let!(:bad_credentials) { FactoryBot.attributes_for(:user, password: 'abcd') }

    context 'When request is valid' do
      before { post '/auth/login', params: good_credentials }

      it 'returns valid ID to use as token' do
        p json
        expect(json['user_id']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/auth/login', params: bad_credentials }

      it 'returns valid ID to use as token' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end

  #get vaildates Torre.co public_id existance

  describe 'GET /auth/person/:id' do
    let (:user) {'canriquez'}
    context 'When request is valid' do
      before { get "/auth/person/#{user}" }

      it 'returns confirmation' do
        p json
        expect(json['message']).to eq('Valid Torre.co User')
      end
    end

    context 'When request is invalid valid' do
      let (:user) {'hohohohohoh'}
      before { get "/auth/person/#{user}" }

      it 'returns error' do
        p json
        expect(json['error']).to eq('Invalid Torre.co User')
      end
    end
  end
end
