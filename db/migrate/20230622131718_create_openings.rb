class CreateOpenings < ActiveRecord::Migration[7.0]
  def change
    create_table :openings do |t|
      t.integer :amount
      t.references :user, null: false, foreign_key: true
      t.string :formatted_date

      t.timestamps
    end
  end
end
