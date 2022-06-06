class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 320
      t.string :first_name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.integer :age, null: false, limit: 4
      t.references :company, foreign_key: true
      t.timestamps
    end

    add_index :users, [:email, :company_id], :unique => true
  end
end
