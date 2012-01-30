class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string :title
      t.string :goal
      t.datetime :start_date
      t.datetime :end_date
      t.references :project

      t.timestamps
    end
    add_index :sprints, :project_id
  end
end
