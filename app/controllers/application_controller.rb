class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :null_session

  protected
    def authorize
      @current_user = User.find_by(id: session[:user_id])
      unless @current_user
        redirect_to login_url, notice: 'Please Login'
      end
    end
end
