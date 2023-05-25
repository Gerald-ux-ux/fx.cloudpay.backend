class AddDateToBalances < ActiveRecord::Migration[7.0]
  def change
    add_column :balances, :date, :date
  end
end
