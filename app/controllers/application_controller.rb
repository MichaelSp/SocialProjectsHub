class ApplicationController < ActionController::Base
  class AccessDenied < Exception
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :create_filter
  before_action do
    User.current = User.find(session[:current_user_id]) if session[:current_user_id]
  end

  rescue_from 'AccessDenied' do |exception|
    not_authorized(exception.message)
  end


  def not_authorized(message)
    flash[:red] = message
    redirect_to projects_path
  end

  def authorize! action, subject
    Authorization.authorize! action, subject, User.current
  end

  private

  def create_filter
    @filter = Filter.new params || {}
  end
end
