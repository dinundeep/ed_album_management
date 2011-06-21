require 'digest/sha2'
class UsersController < ApplicationController
  before_filter :require_user
  # GET /users
  # GET /users.json
  layout 'admin_layout' , :except => [:employee , :change_password]
  def admin
   
  end
  def employee
   render :layout => "employee_layout"
  end
  def change_password
     if current_user.login_role == 'employee'
       render :layout => "employee_layout"
     else
       render :layout => "admin_layout"
     end
  end
  def index
   @users = User.all
   @users = @users.paginate(:page => params[:page], :per_page => 10)
   #@user = User.all.paginate :page => params[:page], :order => 'created_at DESC'
   #@users = User.paginate( :page => 1, :per_page => 2)
   #@users = User.paginate(@users.id, :page => params[:page], :order => 'updated_at DESC')
   #@users = User.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
      end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      @user.login_password = get_encryp_pass(@user.login_password)
      if @user.save
        format.html { redirect_to :controller =>'users',:action => 'admin', notice: 'User was successfully created.' }
      else
        @user.login_password = nil
        format.html { render action: "new" }
      end
    end
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
 
  def modify_password
    current_password = get_encryp_pass(params[:current_password])
    new_password = get_encryp_pass(params[:new_password])
    @user = User.find(:first,:conditions=>[" login_password = ? and id = ? ",current_password, current_user.id])
     if @user then
       @user.login_password = new_password
       @user.save
       redirect_to :action => 'admin'
     else 
        flash[:notice] = "You have entered wrong current password. Please try again"
        redirect_to :action => 'change_password'
      end
   end 

 
end
