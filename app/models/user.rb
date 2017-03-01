class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true

  has_many :user_skills,
           ->{ order("`user_skills`.`point` DESC") },
           dependent: :destroy
  has_many :skills,
           ->{ order("`user_skills`.`point` DESC") },
           through: :user_skills

  accepts_nested_attributes_for :user_skills, :skills


  def add_user_skill(skill_id, point)
    user_skills.create(skill_id: skill_id, point: point)
  end

  def remove_user_skill(skill_id)
    user_skills.find_by(skill_id: skill_id).destroy
  end

  has_secure_password
end
