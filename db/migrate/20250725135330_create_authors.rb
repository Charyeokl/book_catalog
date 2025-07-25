class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.integer :birth_year
      t.text :bio
      t.timestamps
    end
    add_index :authors, :name
  end
end