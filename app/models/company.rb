class Company < ApplicationRecord
  VALID_CODE_REGEX = /\A[a-zA-Z0-9\.'\-]+\z/
  has_many :groups, dependent: :destroy
  validates :code, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_CODE_REGEX}
end
