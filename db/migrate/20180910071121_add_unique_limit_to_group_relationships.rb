class AddUniqueLimitToGroupRelationships < ActiveRecord::Migration
  def change
    add_index :group_relationships, [:user_id, :group_id], unique: true
  end
end
