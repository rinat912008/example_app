class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.references :post, foreign_key: true, null: false, index: true
      t.timestamps
    end

    add_index :likes, %i[user_id post_id], unique: true
  end
end
