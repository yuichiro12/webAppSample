class UserSkill < ApplicationRecord
  has_many :plus_ones, dependent: :destroy

  belongs_to :user
  belongs_to :skill
end
