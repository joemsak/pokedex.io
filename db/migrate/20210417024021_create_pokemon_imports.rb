class CreatePokemonImports < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_imports, id: :uuid do |t|
      t.json :data, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :pokemon_imports, :url, unique: true
  end
end
