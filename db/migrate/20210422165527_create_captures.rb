class CreateCaptures < ActiveRecord::Migration[6.1]
  def change
    create_table :captures, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :pokemon, null: false, foreign_key: true, type: :uuid
      t.timestamp :captured_at

      t.timestamps
    end

    add_index(:captures, [:user_id, :pokemon_id], unique: true)
  end
end
