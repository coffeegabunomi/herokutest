class AddColorcodeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :colorcode, :string
  end
end
