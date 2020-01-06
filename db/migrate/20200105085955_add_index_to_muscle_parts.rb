class AddIndexToMuscleParts < ActiveRecord::Migration[5.2]
  def change
    add_index :muscle_parts, :part, unique: true
  end
end
