class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates :user_id, uniqueness: { scope: :group }
end
