class ChangeColumnToUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :region_id,   :high_id
    rename_column :users, :climate_id,  :low_id
    rename_column :users, :children_id, :hobby_id
    add_column :users, :range_with_store_id, :integer, null: false
  end
end
