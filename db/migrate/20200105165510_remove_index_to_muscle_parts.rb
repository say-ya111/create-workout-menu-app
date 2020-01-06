class RemoveIndexToMuscleParts < ActiveRecord::Migration[5.2]
  def change
    remove_index :muscle_parts, :part
  end
end
