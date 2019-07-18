class CreateCollectionItems < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_items, id: :uuid do |t|
      t.uuid :book_id
      t.uuid :user_id
      t.integer :current_page, null: false, default: 0

      t.timestamps
    end
    add_foreign_key :collection_items, :books, column: :book_id
    add_foreign_key :collection_items, :users, column: :user_id
    add_index :collection_items, [:user_id, :book_id], unique: true
  end
end
