class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :emails
      t.text :bio
      t.string :profile_photo
      t.timestamps
    end
  end
end
