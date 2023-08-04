class RemovecolumnfromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :topics_tables_id
  end
end
