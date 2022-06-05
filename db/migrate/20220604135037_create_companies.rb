class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :code, null: false, limit: 50
      t.timestamps
    end
    add_index :companies, :code, :unique => true
  end
end
