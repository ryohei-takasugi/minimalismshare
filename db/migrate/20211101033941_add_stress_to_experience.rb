class AddStressToExperience < ActiveRecord::Migration[6.0]
  def change
    add_column :experiences, :stress, :string, null: false
  end
end
