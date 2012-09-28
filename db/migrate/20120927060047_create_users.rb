class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.datetime :created_at
      t.string :username
      t.string :fullname
      t.string :email
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
