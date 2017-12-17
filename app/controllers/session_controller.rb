class SessionController < ApplicationController
  skip_before_action :authorize, except: :destroy
  def new
  end

  def create
    user = User.find_by("email = :login or phone = :login", 
      login: params[:login])

    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to index_path
    else
      flash.now[:alert] = 'Invalid user/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out'
  end
end
