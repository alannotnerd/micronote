class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :root_path, :home_path
  end
end
