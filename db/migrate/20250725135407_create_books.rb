class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :isbn, null: false
      t.integer :publication_year, null: false
      t.decimal :rating, precision: 3, scale: 1
      t.integer :page_count
      t.text :description
      t.references :author, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
    add_index :books, :isbn, unique: true
    add_index :books, :title
    add_index :books, :publication_year
    add_index :books, :rating
  end
end