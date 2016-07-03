class AddCategoryToCuriosities < ActiveRecord::Migration
  def change
    add_column :curiosities, :category, :string
  end
end
