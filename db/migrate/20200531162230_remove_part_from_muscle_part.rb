class RemovePartFromMusclePart < ActiveRecord::Migration[5.2]
  def change
    remove_column :muscle_parts, :part, :string
  end
end
