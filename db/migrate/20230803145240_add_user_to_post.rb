class AddUserToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :user_id, :int
    add_column :posts, :post_photo, :string
  end
end
