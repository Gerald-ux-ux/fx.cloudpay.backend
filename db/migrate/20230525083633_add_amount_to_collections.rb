class AddAmountToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :amount, :integer
  end
end
