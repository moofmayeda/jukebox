class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :set_client

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :admin
    devise_parameter_sanitizer.for(:account_update) << :admin
  end

  def set_client
    @client = SoundCloud.new(:client_id => ENV['Client_ID'])
  end
end
