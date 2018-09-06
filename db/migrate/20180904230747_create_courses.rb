class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :group
      t.references :project
      t.datetime :begin_data
      t.datetime :expire_date

      t.timestamps null: false
    end
  end
end
