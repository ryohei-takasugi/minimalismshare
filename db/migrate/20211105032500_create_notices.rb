class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.string :message,  null: false
      t.string :url
      t.boolean :read,    null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
