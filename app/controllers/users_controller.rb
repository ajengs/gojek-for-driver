class UsersController < ApplicationController
  before_action :non_session_only, only: [:new, :create]
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, except: [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: 'Registration success.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'Profile updated.'
    else
      render :edit
    end
  end

  def edit_location
  end

  def set_location
    if @user.set_location(params[:location])
      redirect_to user_path, notice: "Current Location was successfully updated."
    else
      render :edit_location
    end
  end

  private
    def set_user
      @user = @current_user.decorate
    end

    def user_params
      params.require(:user).permit(:email, :phone, :first_name, :last_name, :password, :password_confirmation, :license_plate, :type_id, :current_location)
    end
end
