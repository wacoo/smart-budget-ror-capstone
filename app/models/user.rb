class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :expenses
  has_many :groups

  validates :name, presence: true
  validates :role, presence: true
  validates :name, length: { maximum: 100 }
  validates :role, length: { maximum: 50 }
end
