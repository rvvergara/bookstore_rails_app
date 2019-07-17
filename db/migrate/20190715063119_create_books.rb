class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books, id: :uuid do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.text :description, null: false
      t.string :published_date, null: false
      t.integer :page_count, null: false
      t.string :thumbnail, null: false
      t.string :authors, null: false
      t.string :isbn, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
