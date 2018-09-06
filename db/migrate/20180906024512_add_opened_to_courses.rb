class AddOpenedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :opened, :bool, default: true
  end
end
