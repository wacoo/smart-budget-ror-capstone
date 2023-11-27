class CreateGroupExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :group_expenses do |t|
      t.references :group, foreign_key: true
      t.references :expense, foreign_key: true
      t.timestamps
    end
  end
end
