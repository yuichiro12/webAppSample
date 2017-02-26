# coding: utf-8
class UsersController < ApplicationController
  def home
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(true))
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params(false))
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end

  # paramsへの直接のアクセスを防ぐ
  def user_params(is_new_user)
    # TODO アバター，スキルの追加
    if is_new_user == true
      params.require(:user).permit(:name, :password)
    else
      params.require(:user).permit(:name, :comment, :password)
    end
  end
end
