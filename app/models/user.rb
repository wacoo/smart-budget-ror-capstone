class User < ApplicationRecord
    has_many :expenses
    has_many :groups

  validates :name, presence: true
  validates :role, presence: true
  validates :name, length: { maximum: 100 }
  validates :role, length: { maximum: 50 }
end
