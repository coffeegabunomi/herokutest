class AddColorredToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :colorred, :integer
  end
end
