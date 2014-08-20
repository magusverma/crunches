class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :login_check, :except => [:login,:create]

  # GET /users
  # GET /users.json
  def index
    check_admin
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @u = User.find(session[:user])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    check_admin
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    a = User.where(:username => @user.username)
    if !a.count.eql? 0
      if a.first.password.eql? @user.password      
        @user = a.first
        session[:user] = @user.id
        respond_to do |format|
          format.html { redirect_to '/register' }
        end
      else 
        respond_to do |format|
          format.html { redirect_to '/login' }
        end
      end       
    else
      @user.save
      session[:user] = @user.id
      respond_to do |format|
        format.html { redirect_to '/register', notice: 'User was successfully created.' }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "__________________"
    puts session[:user].eql? params[:id].to_i
    if session[:user].to_i.eql? params[:id].to_i or User.find(session[:user]).username.eql? "admin"
      respond_to do |format|
        if @user.update(user_update_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to "/register" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :team_name, :institute, :contact, :email, :ip)
    end
    def user_update_params
      params.require(:user).permit( :password, :team_name, :institute, :contact, :email)
    end
end
