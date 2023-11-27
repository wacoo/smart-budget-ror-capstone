class Group < ApplicationRecord
    belongs_to :user, class_name: 'User'

    validates :name, presence: true
    validates :icon, presence: true
end
