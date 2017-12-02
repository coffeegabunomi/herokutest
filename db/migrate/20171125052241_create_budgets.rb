class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.date :month
      t.integer :category_id
      t.integer :money
      t.timestamps
    end
  end
end
