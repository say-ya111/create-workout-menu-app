class RemoveColumnFromType < ActiveRecord::Migration[5.2]
  def change
    remove_column :types, :user_id, :integer
  end
end
