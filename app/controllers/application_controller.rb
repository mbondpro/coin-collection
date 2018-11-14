# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Controller
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

	#Authorize an admin via Clearance::Authentication
  def admin_auth
		if signed_out?
      deny_access "You must sign in first."			
		else
	    deny_access "You must be an admin to perform that action." unless current_user.admin
		end
  end

	### Redirection ###

  def store_location
    if request.get?
      session[:return_to] = request.fullpath
    end
  end

  def redirect_back_or(default)
    redirect_to(return_to || default)
    clear_return_to
  end

  def redirect_to_root
    redirect_to('/')
  end

  def return_to
    session[:return_to] || params[:return_to]
  end

	def clear_return_to
		session[:return_to] = nil
	end

end
