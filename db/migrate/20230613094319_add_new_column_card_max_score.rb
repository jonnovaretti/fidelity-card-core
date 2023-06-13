class AddNewColumnCardMaxScore < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :max_score, :integer, null: false, default: 0
  end
end
