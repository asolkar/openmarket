class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.datetime :created_at
      t.string :name
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
