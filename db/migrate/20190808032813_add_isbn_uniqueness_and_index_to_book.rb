class AddIsbnUniquenessAndIndexToBook < ActiveRecord::Migration[5.2]
  def change
    add_index :books, :isbn, unique: true
  end
end
