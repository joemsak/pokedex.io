class CreatePokemon < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon, id: :uuid do |t|
      t.string :name, null: false
      t.integer :external_id, null: false
      t.string :image_url, null: false
      t.json :imported_data
      t.timestamp :imported_at

      t.timestamps
    end
    add_index :pokemon, :name, unique: true
    add_index :pokemon, :external_id, unique: true
    add_index :pokemon, :image_url, unique: true
  end
end
