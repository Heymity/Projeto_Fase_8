class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :description
      t.float :value
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
