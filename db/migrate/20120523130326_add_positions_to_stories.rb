class AddPositionsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :sprint_position, :integer
    add_column :stories, :backlog_position, :integer
  end
end
