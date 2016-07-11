class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_host_name

  def angular
  	render 'layouts/application'
  end

  def get_host_name
  	@host_name = request.host
  end

end
