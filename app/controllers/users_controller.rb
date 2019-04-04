class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new

  end


  def create
    @user = User.new(
        name: params[:name],
        email: params[:email],
        image_name:"default_user.jpg",
        password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User registration has been completed."
      @current_user = @user
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end


  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "Updated your information."
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy

    redirect_to("/")
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in"
      redirect_to("/posts/index")
    else
      @error_message = "Your email or username is incorrect."
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

    def logout
      session[:user_id] = nil
      flash[:notice] = "logged out."
      redirect_to("/login")
    end


    def likes
      @user = User.find_by(id: params[:id])
      @likes = Like.where(user_id: @user.id)
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "You are not authorized."
        redirect_to("/posts/index")
      end
    end

    def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
    end

    def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
    end

  end

