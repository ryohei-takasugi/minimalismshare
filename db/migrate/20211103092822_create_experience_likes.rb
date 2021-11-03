class CreateExperienceLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :experience_likes do |t|
      t.boolean :like          , null: false, default: false
      t.boolean :imitate       , null: false, default: false
      t.references :user       , null: false, foreign_key: true
      t.references :experience , null: false, foreign_key: true
      t.timestamps
    end
  end
end
