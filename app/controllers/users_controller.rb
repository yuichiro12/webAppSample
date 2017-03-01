# coding: utf-8
class UsersController < ApplicationController
  def home
  end
  
  def show
    @user = User.find(params[:id])
    @skill = Skill.new
    @user_skill = UserSkill.new
  end

  def show_skilled_users
    @skilled_users = Skill.find_by(name: params[:name]).users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(s_params(:user, :name, :password, :image))
    logger.debug @user.pretty_inspect

    if User.find_by(name: @user.name)
      flash.now[:danger] = "既にユーザー名が存在します！別の名前にしてください"
      render "new"
    elsif @user.save
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = "保存できませんでした"
      render "new"
    end
  end

  def create_skill
    # TODO トランザクション
    prm_us = s_params(:user_skill, :user_id, :point)
    prm_s = s_params(:skill, :name)
    @user = User.find(prm_us[:user_id])
    @skill = Skill.find_by(prm_s)
    if @skill.nil?
      @skill = Skill.create(prm_s)
    end
    @user.add_user_skill(@skill.id, prm_us[:point])
    render partial: "skill_list"
  end


  def remove_skill
    prm = s_params(false, :user_id, :user_skill_id)
    @user = User.find(prm[:user_id])
    logger.debug prm.pretty_inspect
    UserSkill.find(prm[:user_skill_id]).destroy
    render partial: "skill_list"
  end

  def plus1
    # TODO トランザクション
    prm = s_params(false, :user_skill_id, :plused_user_id)
    user_skill = UserSkill.find(prm[:user_skill_id])
    plus1 = PlusOne.find_by(prm)
    if plus1.nil?
      PlusOne.create(prm)
      user_skill.update!(point: user_skill.point + 1)
    else
      plus1.destroy
      user_skill.update!(point: user_skill.point - 1)
    end
    render json: { point: user_skill.point }
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(s_params(:user, :name, :comment, :image, :password))
      redirect_to @user
    else
      flash.now[:danger] = "保存できませんでした"
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end


  private

    # strong parameter
    def s_params(model, *args)
      if model
        params.require(model).permit(*args)
      else
        params.permit(*args)
      end
    end
end
