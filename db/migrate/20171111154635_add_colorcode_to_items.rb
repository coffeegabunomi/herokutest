class AddColorcodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :colorcode, :string
  end
end
