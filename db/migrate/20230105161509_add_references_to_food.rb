class AddReferencesToFood < ActiveRecord::Migration[7.0]
  def change
    add_reference :foods, :meal, null: false, foreign_key: true
  end
end
