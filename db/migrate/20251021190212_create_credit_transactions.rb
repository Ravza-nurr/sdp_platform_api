class CreateCreditTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :credit_transactions, id: :uuid do |t|
      t.uuid :user_id
      t.integer :amount
      t.integer :transaction_type
      t.string :description
      t.integer :balance_after

      t.timestamps
    end
  end
end
