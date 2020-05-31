class AddReferencesToPart < ActiveRecord::Migration[5.2]
  def change
    add_reference :parts, :type, foreign_key: true
  end
end
