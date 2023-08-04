class ChangesInTopicsTablesAndPosts < ActiveRecord::Migration[7.0]
  def change
    add_column  :topics_tables, :topic_name, :string
    remove_column :posts, :topic
    add_reference :posts, :topics_tables, foreign_key: true

  end
end
