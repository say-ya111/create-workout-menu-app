class CreateMuscleParts < ActiveRecord::Migration[5.2]
  def change
    create_table :muscle_parts do |t|
      t.references :user
      t.string :part
      t.date :last_date

      t.timestamps
    end
  end
end
