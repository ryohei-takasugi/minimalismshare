class AddIndexToExperiencesCreatedAt < ActiveRecord::Migration[6.0]
  def change
    add_index :experiences, :created_at, unique: true
  end
end
