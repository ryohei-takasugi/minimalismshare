class ChangeColumnToNotice < ActiveRecord::Migration[6.0]
  def up
    change_column :notices, :read, :boolean, null: false, default: false
  end
  def down
    change_column :notices, :read, :boolean, null: false
  end
end
