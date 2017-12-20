module ErrorHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from Errno::ECONNREFUSED, with: :server_down
  end

  private
    def server_down
      render 'error_handler/server_down'
    end
end