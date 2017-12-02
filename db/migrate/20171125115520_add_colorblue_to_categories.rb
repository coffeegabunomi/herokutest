class AddColorblueToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :colorblue, :integer
  end
end
