# coding: utf-8
class UsersController < ApplicationController
  def home
  end
  
  def show
    @user = User.find(params[:id])
    @user.skills = Skill.includes(:user_skills => :plus_ones)
                     .where(user_skills: {user_id: params[:id]})
                     .order("`user_skills`.`point` DESC")
    @skill = Skill.new
    @user_skill = UserSkill.new
    logger.debug @user.user_skills.inspect
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
    # TODO 失敗時のフラッシュメッセージ
    # TODO リファクタ，パーシャル読み込みとか追加
    relation_params = user_skill_params
    @user = User.find(relation_params[:user_skill][:user_id])
    @skill = Skill.create(skill_params)
    if @skill && !@skill.id.nil?
      if @user.add_user_skill(@skill.id, relation_params[:user_skill][:point])
        render
      else
        render "show"
      end
    else
      render "show"
    end
  end

  def create_plus_one
    # TODO Unique制約，バリデーション，トランザクション
    # TODO 失敗時のフラッシュメッセージ
    # TODO リファクタ，パーシャル読み込みとか追加
    user_skill = UserSkill.find(plus_one_params[:user_skill_id])
    if PlusOne.find_by(plus_one_params).nil?
      PlusOne.create(plus_one_params)
      user_skill.update!(point: user_skill.point + 1)
    end
    render json: { point: user_skill.point }
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params(false))
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end


  private

    # strong parameter
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

    def plus_one_params
      params.permit(:user_skill_id, :plused_user_id)
    end
end
