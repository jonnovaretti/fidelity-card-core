class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.integer :score, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.datetime :expires_at

      t.timestamps
    end
  end
end
