class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :day
      t.integer :money
      t.integer :item_id

      t.timestamps
    end
  end
end
