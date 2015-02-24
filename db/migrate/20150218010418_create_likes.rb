class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :bookmark
      t.string :user

      t.timestamps null: false
    end
    add_index :likes, :user
  end
end
