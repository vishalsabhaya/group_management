class Group < ApplicationRecord
  belongs_to :company
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :company }
end
