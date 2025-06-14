class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :description
      t.float :target_amount
      t.float :current_amount, default: 0.0
      t.references :user, null: false, foreign_key: true
      t.datetime :target_date
      t.string :status, default: 'pending' # 'pending', 'in_progress', 'achieved', 'failed'
      t.timestamps
    end
  end
end
