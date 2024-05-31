class CreateData < ActiveRecord::Migration[7.1]
  def change
    create_table :data do |t|
      t.integer :price
      t.date :date
      t.references :product, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
