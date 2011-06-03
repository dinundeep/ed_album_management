
class HomeController < ApplicationController
  def login
  end

  def logout
    session[:current_user] = nil unless session[:current_user].nil?
    redirect_to :action => 'login'
  end

  def check_login
    login = params[:login]
    password = get_encryp_pass(params[:password])
    @user = User.find(:first,:conditions=>[" login_name = ? and login_password = ? ",login,password] )
    if @user 
      if @user.login_role =="admin" then
	  session[:current_user] = @user
	  flash[:note]="Welcome admin " + @user.login_name
	  redirect_to :controller =>'users',:action => 'admin'
      elsif(@user.login_role=="employee") then
	  session[:current_user] = user.id
	  flash[:note]="Welcome employee " + @user.login_name
	  redirect_to :controller =>'users', :action => 'employee'
      end 
    else
      redirect_to :action => 'login'
    end
  end
  

   
   
end
