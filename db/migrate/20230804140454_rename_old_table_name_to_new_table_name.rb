class RenameOldTableNameToNewTableName < ActiveRecord::Migration[7.0]
  def change
    rename_table :topics_tables, :topics
    rename_table :likes_tables, :likes
    rename_table :comments_tables, :comments
    rename_table :follows_tables, :follows
  end
end

