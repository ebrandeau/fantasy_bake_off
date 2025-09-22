class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :admin?, :contestants_for

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user&.is_admin?
  end

  def require_login
    return if current_user

    redirect_to new_session_path, alert: "Please select a user"
  end

  def require_admin
    return if admin?

    redirect_to root_path, alert: "Admins only"
  end

  def contestants_for(season)
    season.contestants.order(:name)
  end
end
