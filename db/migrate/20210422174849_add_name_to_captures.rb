class AddNameToCaptures < ActiveRecord::Migration[6.1]
  def change
    add_column :captures, :name, :string
  end
end
