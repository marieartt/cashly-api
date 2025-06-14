class CreateCreditCards < ActiveRecord::Migration[8.0]
  def change
    create_table :credit_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :number
      t.date :expiration_date
      t.string :name
      t.string :brand

      t.timestamps
    end
  end
end
