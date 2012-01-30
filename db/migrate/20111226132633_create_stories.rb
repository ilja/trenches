class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.references :project
      t.references :sprint

      t.timestamps
    end
    add_index :stories, :project_id
    add_index :stories, :sprint_id
  end
end
