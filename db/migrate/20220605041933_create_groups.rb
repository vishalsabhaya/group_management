class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false, limit: 100
      t.references :company, foreign_key: true
      t.timestamps
    end

    add_index :groups, [:name, :company_id], :unique => true
  end
end
