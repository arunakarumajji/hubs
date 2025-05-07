class Hub < ApplicationRecord
  has_many :admins, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :email_configs, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true
  validates :slug , presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    self.slug ||= name.parameterize if name.present?
  end
end
