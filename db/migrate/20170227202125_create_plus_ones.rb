class CreatePlusOnes < ActiveRecord::Migration[5.0]
  def change
    create_table :plus_ones do |t|
      t.integer :plused_user_id
      t.integer :user_skill_id

      t.timestamps
    end

    add_index :plus_ones, :plused_user_id unless index_exists?(:plus_ones, :plused_user_id)
    add_index :plus_ones, :user_skill_id unless index_exists?(:plus_ones, :user_skill_id)
    add_index :plus_ones, [:plused_user_id, :user_skill_id], unique: true unless index_exists?(:plus_ones, [:plused_user_id, :user_skill_id])
  end
end
