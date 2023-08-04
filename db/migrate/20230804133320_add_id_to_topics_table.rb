class AddIdToTopicsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :topics_tables, :id, :primary_key
  end
end
