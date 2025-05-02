class User < ApplicationRecord
  has_secure_password validations: false
  belongs_to :hub
  has_many :user_challenges, dependent: :destroy
  has_many :challenges, through: :user_challenges
  has_many :completed_challenges, -> { where(user_challenges: {completed: true}) }, through: :user_challenges, source: :challenge
  has_many :pending_challenges, -> { where(user_challenges: {completed: false}) }, through: :user_challenges, source: :challenge

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :password, presence: { if: :password_required? },
  #           length: { minimum: 6, if: :password_required? },
  #           confirmation: { if: :password_required? }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_being_set?

  # validates :password_confirmation, presence: true, on: :create
  validates :email, presence: true, uniqueness: { scope: :hub_id }, format: { with: URI::MailTo::EMAIL_REGEXP }
  enum :status, { pending: 0, active: 1, inactive: 2 }, default: :pending

  def full_name
    return "" if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}"
  end

  def password_being_set?
    # Check if password is present in the attributes hash but not yet saved to password_digest
    # This returns true only when password is being set intentionally
    password.present?
  end

end
