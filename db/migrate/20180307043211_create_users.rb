class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.datetime :birthday
      t.string :first_name
      t.string :last_name
      t.string :patronymic
      t.string :email
      t.string :password_digest
      t.integer :doctor_id
      t.integer :position
      t.integer :sex

      t.timestamps
    end
  end
end
