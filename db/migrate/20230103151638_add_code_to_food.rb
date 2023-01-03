class AddCodeToFood < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :code, :string
  end
end
