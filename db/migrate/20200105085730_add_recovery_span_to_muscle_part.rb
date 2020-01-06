class AddRecoverySpanToMusclePart < ActiveRecord::Migration[5.2]
  def change
    add_column :muscle_parts, :recovery_span, :integer
  end
end
