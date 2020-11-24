class UsersController < ApplicationController
    
    def login
    
        if current_user 
            response = {user_id: @user.id}
        else
            response = {message: 'Invalid credentials'}
        end

        json_response(response)
        
    end


    private

    def user_params
        params.permit(
          :public_id,
          :password
        )
    end

    def current_user
        @user = User.find_by(public_id: params[:public_id])
        p user_params
        p @user
        p params[:password]
        if  @user && @user.authenticate(params[:password])
            puts "THIS IS TRUE!"
            return true
        else
            return false
        end
    end


end
