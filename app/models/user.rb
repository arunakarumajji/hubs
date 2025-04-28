class User < ApplicationRecord
  belongs_to :hub
  validates :email, presence: true, uniqueness: { scope: :hub_id }, format: { with: URI::MailTo::EMAIL_REGEXP }
  enum :status, { pending: 0, active: 1, inactive: 2 }, default: :pending

  def full_name
    "#{first_name} #{last_name}"
  end
end
