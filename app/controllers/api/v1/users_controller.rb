class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize

  def check_if_exists
    user = User.find_by('email = :email OR phone = :phone', email: user_params[:email], phone: user_params[:phone])

    if user.nil?
      render json: {user_exists: false}
    else
      render json: {user_exists: true}
    end
  end

  private
    def user_params
      params.permit(:email, :phone, :first_name, :last_name, :password, :password_confirmation)
    end
end