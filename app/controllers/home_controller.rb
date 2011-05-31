
class HomeController < ApplicationController

  def logout
    session[:current_user] = nil unless session[:current_user].nil?
    redirect_to :action => 'login'
  end
  
  def admin

  end

  def check_login
    login = params[:login]
    #pass = params[:password]
    pass = Digest::MD5.hexdigest(params[:password])
    user = User.find(:first,:conditions=>[" login_name = ? and login_password = ? ",login,pass] )
debugger
    if user 
      if user.login_role =="admin" then
	  session[:current_user] = user.id
	  flash[:note]="Welcome admin "+user.login_name
	  redirect_to :action => 'admin'
      elsif(user.login_role=="employee") then
	  session[:current_user] = user.id
	  flash[:note]="Welcome employee "+user.login_name
	  redirect_to :action => 'employee'
	  #elsif(user.login_role=="") then
	  #      redirect_to :action => 'login'
	  #else
	    #  redirect_to :action => 'login'
      end 
    else
      redirect_to :action => 'login'
    end
  end

   def modify_password
       c_password = get_encryp_pass(params[:current_password])
       n_password = get_encryp_pass(params[:new_password])
       @user = User.find(:first,:conditions=>[" login_password = ? ",c_password])
       if @user then
        @user.login_password = n_password
        @user.save
        redirect_to :action => 'admin'
      end
    end 
   
end
