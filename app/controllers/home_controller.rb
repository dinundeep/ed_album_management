class HomeController < ApplicationController

  def login
    
  end
  def employee

  end

  def admin
   end
  
def check_login
     login = params[:login]
     pass = params[:password]
     user = User.find(:first,:conditions=>[" login_name = ? and login_pass = ? ",login,pass] )
     if user.nil?
        redirect_to :action => 'admin'
     else 
       redirect_to :action => 'employee'
     end
  end

end
