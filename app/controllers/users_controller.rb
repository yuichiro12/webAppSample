# coding: utf-8
class UsersController < ApplicationController
  def home
  end
  
  def show
    @user = User.find(params[:id])
    @user.skills = Skill.joins(:user_skills)
                     .select(:name, :point)
                     .where(user_skills: {user_id: params[:id]})
                     .order("`user_skills`.`point` DESC")
    logger.debug @user.skills.nil?.inspect
    
    @skill = Skill.new
    @user_skill = UserSkill.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(true))
    # TODO フラッシュメッセージ
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end

  def create_skill
    # TODO スキルのUnique制約，バリデーション
    # TODO リファクタ，パーシャル読み込みとか追加
    relation_params = user_skill_params
    @user = User.find(relation_params[:user_skill][:user_id])
    @skill = Skill.create(skill_params)
    if !@skill.id.nil?
      if @user.add_user_skill(@skill.id, relation_params[:user_skill][:point])
        render
      else
        render "show"
      end
    else
      render "show"
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
    # TODO アバターの追加
    if is_new_user == true
      params.require(:user).permit(:name, :password)
    else
      params.require(:user).permit(:name, :comment, :password)
    end
  end

  def skill_params
    params.require(:skill).permit(:name)
  end

  def user_skill_params
    params.require(:skill).permit(user_skill: [:user_id, :point])
  end
end
