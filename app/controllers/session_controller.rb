class SessionController < ApplicationController
  skip_before_action :authorize, except: :destroy
  def new
  end

  def create
    user = User.find_by("email = :email or phone = :phone", 
      email: params[:login], 
      phone: params[:login])

    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to index_path
    else
      render :new, alert: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out'
  end
end
