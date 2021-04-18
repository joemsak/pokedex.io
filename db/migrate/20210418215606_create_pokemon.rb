class CreatePokemon < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :external_id, null: false
      t.string :image_url, null: false
      t.timestamp :imported_at, null: false
      t.references :pokemon_import, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :pokemon, :name, unique: true
    add_index :pokemon, :slug, unique: true
    add_index :pokemon, :external_id, unique: true
    add_index :pokemon, :image_url, unique: true

    reversible do |dir|
      dir.up do
        remove_index :pokemon, :pokemon_import_id
        add_index :pokemon, :pokemon_import_id, unique: true
      end

      dir.down do
        remove_index :pokemon, :pokemon_import_id
      end
    end
  end
end
