class SessionController < ApplicationController
  before_action :non_session_only, except: :destroy
  skip_before_action :authorize, except: :destroy
  def new
  end

  def create
    user = User.find_by("email = :login or phone = :login", login: params[:login])

    if user.try(:authenticate, params[:password])
      session[:gopartner_user_id] = user.id
      redirect_to index_path
    else
      flash.now[:alert] = 'Invalid user/password combination'
      render :new
    end
  end

  def destroy
    session[:gopartner_user_id] = nil
    redirect_to login_path, notice: 'Logged out'
  end
end
