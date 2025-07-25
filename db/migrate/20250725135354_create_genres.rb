class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :genres, :name, unique: true
  end
end