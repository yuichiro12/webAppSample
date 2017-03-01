# coding: utf-8
class UsersController < ApplicationController
  def home
  end
  
  def show
    @user = User.find(params[:id])
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
    # TODO 失敗時のフラッシュメッセージ
    # TODO リファクタ，パーシャル読み込みとか追加
    relation_params = user_skill_params
    @user = User.find(relation_params[:user_id])
    @skill = Skill.create(skill_params)
    if @skill && !@skill.id.nil?
      @user.add_user_skill(@skill.id, relation_params[:point])
    end
    render partial: "skill_list"
  end

  def plus1
    # TODO Unique制約，バリデーション，トランザクション
    # TODO 失敗時のフラッシュメッセージ
    # TODO リファクタ，パーシャル読み込みとか追加
    user_skill = UserSkill.find(plus1_params[:user_skill_id])
    plus1 = PlusOne.find_by(plus1_params)
    if plus1.nil?
      PlusOne.create(plus1_params)
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
      params.require(:user_skill).permit(:user_id, :point)
    end

    def plus1_params
      params.permit(:user_skill_id, :plused_user_id)
    end
end
