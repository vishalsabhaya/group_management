class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\z/
  USER_LIMIT = 10
  MIN_AGE = 18
  belongs_to :company
  has_many :user_groups
  has_many :groups, through: :user_groups, dependent: :destroy
  validates :email, presence: true, uniqueness: { scope: :company }, length: { maximum: 320 }, format: { with: VALID_EMAIL_REGEX}
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :age, presence: true
  validate :validate_age
  validate :user_limit, on: :create

  private

  def validate_age
    if age.present? && age < MIN_AGE
      errors.add(:age,I18n.t('E0002'))
    end
  end

  def user_limit
    if ((company&.users&.count || 0) + 1) > USER_LIMIT
      errors.add(:user_limit, I18n.t('E0001'))
    end
  end
end
