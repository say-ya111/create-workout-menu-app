class AddReferencesToType < ActiveRecord::Migration[5.2]
  def change
    add_reference :types, :part, foreign_key: true
  end
end
