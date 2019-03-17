class UsersController < ApplicationController
  def index
  end

  def show
    @post = Post.find_by(id: params[:id])

  end

  def new

  end

  def edit
    @post = Post.find_by(id: params[:id])

  end

  def create

  end

  def update

  end

  def destroy

  end

  def login

  end

  def login_form

  end

  def logout

  end

  def likes

  end
end
