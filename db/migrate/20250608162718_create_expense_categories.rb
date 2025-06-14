class CreateExpenseCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_categories do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
