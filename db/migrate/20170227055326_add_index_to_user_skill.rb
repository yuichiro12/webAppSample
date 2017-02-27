class AddIndexToUserSkill < ActiveRecord::Migration[5.0]
  def up
    add_index :user_skills, :user_id unless index_exists?(:user_skills, :user_id)
    add_index :user_skills, :skill_id unless index_exists?(:user_skills, :skill_id)
    add_index :user_skills, [:user_id, :skill_id], unique: true unless index_exists?(:user_skills, [:user_id, :skill_id])
  end

  def down
    remove_index :user_skills, :user_id
    remove_index :user_skills, :skill_id
    remove_index :user_skills, [:user_id, :skill_id], unique: true
  end
end
