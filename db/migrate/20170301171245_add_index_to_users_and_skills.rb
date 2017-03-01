class AddIndexToUsersAndSkills < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :name, unique: true
    add_index :skills, :name, unique: true
  end
end
