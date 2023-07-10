class AddDateToClosing < ActiveRecord::Migration[7.0]
  def change
    add_column :closings, :date, :date
  end
end
