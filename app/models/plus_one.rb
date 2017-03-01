class PlusOne < ApplicationRecord
  belongs_to :user_skill
  belongs_to :user, foreign_key: :plused_user_id
end
