class UsersController < ApplicationController
  def login
    if valid_login_user
      json_response({ user_id: @user.id })
    else
      json_response({ message: 'Invalid credentials' })
    end
  end

  # POST /signup
  def create
    p user_params
    user = User.new(user_params)

    user.save
    if user.valid?
      json_response({ user_id: user.id })
    else
      json_response({ message: 'Signup error', error: user.errors.messages })
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

  def valid_login_user
    @user = User.find_by(public_id: params[:public_id])
    return true if @user&.authenticate(params[:password])

    false
  end
end
