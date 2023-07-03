class CreateDisbursments < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursments do |t|
      t.integer :disbursment
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
