class AddColorgreenToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :colorgreen, :integer
  end
end
