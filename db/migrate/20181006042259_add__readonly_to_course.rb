class AddReadonlyToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :_readonly, :boolean, default: false
  end
end
