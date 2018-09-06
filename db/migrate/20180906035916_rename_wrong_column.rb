class RenameWrongColumn < ActiveRecord::Migration
  def change
    rename_column :courses, :begin_data, :begin_date
  end
end
