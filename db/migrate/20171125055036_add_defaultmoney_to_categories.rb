class AddDefaultmoneyToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :defaultmoney, :integer
  end
end
