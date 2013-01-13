class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.datetime :created_at
      t.string :email
      t.string :fullname
      t.string :username
      t.integer :id
      t.string :password_digest

      t.timestamps
    end
  end
end
