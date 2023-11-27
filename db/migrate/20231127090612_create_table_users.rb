class CreateTableUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :role

      t.datetime :created_at
    end
  end
end
