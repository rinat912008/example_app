class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.text :message, null: false
      t.boolean :published, default: true, null: false
      t.timestamps
    end
  end
end
