class SessionsController < ApplicationController
  before_action :require_login, only: :destroy

  def new
    return redirect_to seasons_path if current_user

    @users = User.order(:name)
  end

  def create
    user = User.find_by(id: params[:user_id])

    if user
      session[:user_id] = user.id
      redirect_to seasons_path, notice: "Welcome back, #{user.name}!"
    else
      redirect_to new_session_path, alert: "Please select a valid user"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end
