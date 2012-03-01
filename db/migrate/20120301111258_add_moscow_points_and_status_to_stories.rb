class AddMoscowPointsAndStatusToStories < ActiveRecord::Migration
  def change
    add_column :stories, :points, :integer
    add_column :stories, :moscow, :integer
    add_column :stories, :status, :integer
    add_index :stories, :status
  end
end
