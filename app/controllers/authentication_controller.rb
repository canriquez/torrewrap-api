class AuthenticationController < ApplicationController

    def person_check
        @torreco = Torreco::Search.by_public_id(params[:id])
        if JSON.parse(@torreco.body)["message"] == 'Person not found!'
          json_response({ error: 'Invalid Torre.co User'})
        else
          json_response({ message: 'Valid Torre.co User'})
        end
    end
    
    def valid_wrap_user_check
        @user = User.find_by(public_id: params[:id])
        if !@user
          json_response({ error: 'Invalid TowerWrap User'})
        else
          json_response({ message: 'Valid TorreWrap User'})
        end
    end
end
