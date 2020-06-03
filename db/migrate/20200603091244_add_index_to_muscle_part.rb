class AddIndexToMusclePart < ActiveRecord::Migration[5.2]
  def change
    add_index :muscle_parts, [:user_id, :part_id], unique: true
  end
end
