class Group < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :group_expenses
  has_many :expenses, through: :group_expenses
  has_one_attached :icon

  validates :name, presence: true
end
