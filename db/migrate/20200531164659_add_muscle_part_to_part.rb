class AddMusclePartToPart < ActiveRecord::Migration[5.2]
  def change
    add_reference :parts, :muscle_part, foreign_key: true
  end
end
