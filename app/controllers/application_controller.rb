class ApplicationController < ActionController::Base
  include Geocoder
  before_action :authorize
  protect_from_forgery with: :null_session

  protected
    def authorize
      @current_user = User.find_by(id: session[:gopartner_user_id])
      unless @current_user
        redirect_to login_url, notice: 'Please Login'
      else
        @current_user = @current_user.decorate
      end
    end

    def non_session_only
      if session[:gopartner_user_id]
        redirect_to index_path, notice: 'Please logout first'
      end
    end
end
