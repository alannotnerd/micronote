class AddUniqueLimitToProjects < ActiveRecord::Migration
  def change
    remove_index :projects, [:user_id, :name]
    add_index :projects, [:user_id, :name, :pushed_by], unique: true
  end
end
