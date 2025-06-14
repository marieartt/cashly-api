class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :credit_card, null: false, foreign_key: true
      t.string :description
      t.decimal :amount
      t.datetime :transaction_date
      t.string :category

      t.timestamps
    end
  end
end
