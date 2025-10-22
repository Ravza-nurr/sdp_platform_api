class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :encrypted_password
      t.integer :role
      t.string :name
      t.string :institution

      t.timestamps
    end
  end
end
