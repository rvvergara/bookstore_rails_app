class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render_error(nil, "Unauthorized update", :unauthorized)
  end

  def user_data(user)
    {
      id: user.id,
      email: user.email,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      access_level: user.access_level
    }
  end

  def render_error(resource, message, status)
    errors = resource ? resource.errors : { general: "Cannot process request" }
    render json: {
      message: message,
      errors: errors
    }, status: status
  end

  def pundit_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      decoded = JsonWebToken.decode(header)
      
      @current_user = User.find(decoded['id'])
    rescue ActiveRecord::RecordNotFound => e
      render_error(@current_user, e.message, :unauthorized)
    rescue JWT::DecodeError => e
      render_error(@current_user, e.message, :unauthorized)
    end
  end

  def allow_correct_user(user)
    if @current_user != user
      render_error(@current_user, "Unauthorized Request", :unauthorized)
    end
  end
end
