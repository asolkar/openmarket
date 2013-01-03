class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.datetime :created_at
      t.string :name

      t.timestamps
    end
  end
end
