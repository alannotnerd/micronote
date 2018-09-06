class AddLevelToGroupRelationships < ActiveRecord::Migration
  def change
    add_column :group_relationships, :level, :int, default: 10
  end
end
