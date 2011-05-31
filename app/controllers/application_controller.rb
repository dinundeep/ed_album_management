require 'digest/sha2'
class ApplicationController < ActionController::Base
  protect_from_forgery


private 

  def get_encryp_pass(orig_pass)
   Digest::MD5.hexdigest(orig_pass)
  end

  def require_user
    redirect_to login_home_index_path and return if session[:current_user].blank?
  end

end

