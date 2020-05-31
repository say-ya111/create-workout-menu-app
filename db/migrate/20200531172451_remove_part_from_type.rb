class RemovePartFromType < ActiveRecord::Migration[5.2]
  def change
    remove_column :types, :part, :string
  end
end
