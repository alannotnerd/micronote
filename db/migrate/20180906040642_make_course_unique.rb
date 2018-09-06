class MakeCourseUnique < ActiveRecord::Migration
  def change
    add_index :courses, [:group_id, :project_id], unique: true
  end
end
