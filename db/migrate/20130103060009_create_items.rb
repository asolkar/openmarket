class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.datetime :created_at
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :quantity
      t.boolean :active

      t.timestamps
    end
  end
end
