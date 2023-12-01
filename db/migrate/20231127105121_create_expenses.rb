class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.references :author, foreign_key: { to_table: :users }
      t.string :name
      t.float :amount
      t.datetime :created_at
    end
  end
end
