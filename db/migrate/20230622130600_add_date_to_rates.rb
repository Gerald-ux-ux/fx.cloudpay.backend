class AddDateToRates < ActiveRecord::Migration[7.0]
  def change
    add_column :rates, :date, :date
  end
end
