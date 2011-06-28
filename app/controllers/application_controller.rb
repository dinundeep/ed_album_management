require 'digest/sha2'
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :set_layout
  def current_user
    #@current_user ||= User.find(session[:current_user].to_i)
    session[:current_user]
  end
  def set_layout
    if current_user.login_role == 'Admin'
       'admin_layout'
    else if current_user.login_role=='employee'
       'employee_layout'
       else
         'application'
     end
    end
  end

private

  def get_encryp_pass(orig_pass)
   Digest::MD5.hexdigest(orig_pass)
  end

  def require_user
    redirect_to login_home_index_path and return if session[:current_user].blank?
  end

end

