class AddPushedByToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :pushed_by, :int
  end
end
