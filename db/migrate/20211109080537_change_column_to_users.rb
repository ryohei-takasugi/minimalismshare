class ChangeColumnToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :high_id,             :integer, null: false, default: 0
    change_column :users, :low_id,              :integer, null: false, default: 0
    change_column :users, :hobby_id,            :integer, null: false, default: 0
    change_column :users, :range_with_store_id, :integer, null: false, default: 0
    change_column :users, :housemate_id,        :integer, null: false, default: 0
    change_column :users, :clean_status_id,     :integer, null: false, default: 0
  end
  def down
    change_column :users, :high_id,             :integer, null: false
    change_column :users, :low_id,              :integer, null: false
    change_column :users, :hobby_id,            :integer, null: false
    change_column :users, :range_with_store_id, :integer, null: false
    change_column :users, :housemate_id,        :integer, null: false
    change_column :users, :clean_status_id,     :integer, null: false
  end
end
