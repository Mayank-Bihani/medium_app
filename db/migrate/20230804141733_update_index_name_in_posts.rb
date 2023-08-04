class UpdateIndexNameInPosts < ActiveRecord::Migration[7.0]
  def change
    # remove_reference :posts, :topics_tables, foreign_key: true
    add_reference :posts, :topics, foreign_key: true
  end
end
