class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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

  def login_page
    # #if cookie user_id is not empty && the id exists in the database, redirect to welcome back page.(redirect_to sends a new request to the system)
    # if !cookies[:user_id].nil? && !User.find(cookies[:user_id]).nil?
    #  redirect_to 'welcome_page.html.erb'
    # end
  end

  def perform_login
    #   # store the object found through parameters long_email into the instance variable
    @user = User.find_by_email(params[:login_email])
    #   # if a user was found and the password entered by userd matches, store the user id in a cookie and render the welcome back page
    if !@user.nil? && @user.password == params[:password]
        cookies[:user_id] = @user.id
        redirect_to "/users/welcome_page"
    #   # if a user wasn't found, flash a message and render show login page.
    else
        flash[:notice] = "Please enter valid credentials"
        render '/'
        #render means the action is not executed only the view is render
    end
  end

  def welcome_page
  # #For our welcome back view to have access to the full_name, we need to store the object into a variable.
    @user = User.find(cookies[:user_id])
    @blogs = Blog.all
  end

 #---------not write below this line -------------
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:full_name, :email, :password)
    end

end
