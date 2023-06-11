class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :customers, %i[name phone company_id], unique: true
  end
end
