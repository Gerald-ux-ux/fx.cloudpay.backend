class AddDateToOpenings < ActiveRecord::Migration[7.0]
  def change
    add_column :openings, :date, :date
  end
end
