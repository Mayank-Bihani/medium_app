class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :topic
      t.text :post_text
      t.timestamps
    end
  end
end
