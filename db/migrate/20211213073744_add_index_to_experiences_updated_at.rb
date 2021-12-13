class AddIndexToExperiencesUpdatedAt < ActiveRecord::Migration[6.0]
  def change
    add_index :experiences, :updated_at, unique: true
  end
end
