class UsersController < ApplicationController
    
    def login
    
        if valid_login_user 
            response = {user_id: @user.id}
        else
            response = {message: 'Invalid credentials'}
        end

        json_response(response)
        
    end

    #POST /signup
    def create
        p user_params
        user = User.new(user_params)

        user.save
        if user.valid?
            response = {user_id: user.id}
        else
            response = {message: 'Signup error', error: user.errors.messages}
        end
        json_response(response)
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
        if  @user && @user.authenticate(params[:password])
            return true
        else
            return false
        end
    end


end
