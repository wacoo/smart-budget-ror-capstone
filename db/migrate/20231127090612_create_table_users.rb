class CreateTableUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.datetime :created_at
    end
  end
end
