class Group < ApplicationRecord
  belongs_to :company
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :company }
end
