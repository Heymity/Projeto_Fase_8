class CreateGains < ActiveRecord::Migration[5.0]
  def change
    create_table :gains do |t|
      t.string :descripition
      t.float :value
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
