class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user
      t.references :project
      t.boolean :project_owner, :default => false

      t.timestamps
    end
    add_index :members, :user_id
    add_index :members, :project_id
  end
end
