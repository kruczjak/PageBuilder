module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!

    # Renders current user, requires authentication.
    # @return [serialized User] current_user serialized using user_serializer
    def show
      render json: current_user
    end
  end
end
