class AddProjectRootPathToUsers < ActiveRecord::Migration
  def change
    add_column :users, :root_path, :string
  end
end
