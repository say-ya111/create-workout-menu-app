class AddPartColumnToTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :types, :part, :string
  end
end
