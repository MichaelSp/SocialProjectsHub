class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_name(session_params[:login]) || User.where('lower(email) = ?', session_params[:login].downcase).first
    if user.try(:authenticate, session_params[:password])
      session[:current_user_id] = user.id
      User.current = user
      redirect_to projects_path, green: "Hello #{user.name}"
    else
      @user = User.new name: session_params[:login]
      flash[:red] = 'Authentication failed!'
      render 'sessions/new'
    end
  end

  def destroy
    session.delete :current_user_id
    User.current = nil
    redirect_to projects_path
  end

  private
  def session_params
    params.require(:user).permit(:login, :password) if params[:user]
  end
end
