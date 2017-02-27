class Skill < ApplicationRecord
  validates :name, presence: true

  has_many :user_skills,
           dependent: :destroy
  has_many :skills, through: :user_skills
end
