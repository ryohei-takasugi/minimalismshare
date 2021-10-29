class ChangeColumnToExperience < ActiveRecord::Migration[6.0]
  def change
    rename_column :experiences, :days_id, :period_id
  end
end
