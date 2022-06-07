class Group < ApplicationRecord
  belongs_to :company
  has_many :user_groups
  has_many :users, through: :user_groups, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :company }
end
