# coding: utf-8
class User < ApplicationRecord
  attr_accessor :skills

  validates :name, presence: true
  validates :password, presence: true

  has_many :user_skills,
           dependent: :destroy

  accepts_nested_attributes_for :user_skills


  def add_user_skill(skill_id, point)
    user_skills.create(skill_id: skill_id, point: point)
  end

  def remove_user_skill(skill_id)
    user_skills.find_by(skill_id: skill_id).destroy
  end

  # TODO 使うかも
  def has_skill?(skill_id)
  end

  has_secure_password
end
