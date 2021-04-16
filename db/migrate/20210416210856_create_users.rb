class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.string :slug

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
    add_index :users, :slug, unique: true
  end
end
