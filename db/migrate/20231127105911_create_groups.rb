class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :icon
      t.references :user, foreign_key: true
      t.datetime :created_at
    end
  end
end
