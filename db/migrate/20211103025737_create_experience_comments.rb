class CreateExperienceComments < ActiveRecord::Migration[6.0]
  def change
    create_table :experience_comments do |t|
      t.text :comment
      t.references :user,       null: false, foreign_key: true
      t.references :experience, null: false, foreign_key: true
      t.timestamps
    end
  end
end
