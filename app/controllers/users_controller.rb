require 'json'
class UsersController < ApplicationController
  before_action :none_existing_only, only: :create

  def login
    if valid_login_user
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
    else
      json_response({ message: 'Invalid credentials' })
    end
  end

  # POST /signup
  def create
    p user_params
    #Checks Torreco response for user profile
    @torreco = Torreco::Search.by_public_id(user_params[:public_id])
    p JSON.parse(@torreco.body)

    if JSON.parse(@torreco.body)['message'] == 'Person not found!'
      json_response({ message: JSON.parse(@torreco.body)['message'] + ' in Torre.co. Please use a valid username.' })
    else
      user = User.new(user_params)
      user.picture_thumbnail = JSON.parse(@torreco.body)['person']['pictureThumbnail'].presence || 'https://anri-img-storage.s3.amazonaws.com/avatar/empty.png' 
      user.name = JSON.parse(@torreco.body)['person']['name']
      user.json_response = JSON.parse(@torreco.body)['person'].to_json
      user.save
      if user.valid?
        json_response({
                        user_id: user.id,
                        user_name: user.name,
                        picture_thumbnail: user.picture_thumbnail,
                        video_url: user.video_url,
                        public_id: user.public_id,
                        torre_data: user.json_response,
                        created_at: user.created_at,
                        updated_at: user.updated_at
                      })
      else
        json_response({ message: 'Signup error', error: user.errors.messages })
      end
    end
  end

  private

  def user_params
    params.permit(
      :public_id,
      :password,
      :password_confirmation,
      :picture_thumbnail,
      :name
    )
  end

  def none_existing_only
    @user = User.find_by(public_id: params[:public_id])
    return unless @user

    json_response(error: 'User already exists torreWrap. Please login instead.')
  end

  def valid_login_user
    @user = User.find_by(public_id: params[:public_id])
    return true if @user&.authenticate(params[:password])

    false
  end
end
