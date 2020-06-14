class AddColumnToType < ActiveRecord::Migration[5.2]
  def change
    add_column :types, :user_id, :integer, default: 0
  end
end
