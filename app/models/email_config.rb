class EmailConfig < ApplicationRecord
  belongs_to :hub

  validates :subject, :body, :from_email, presence: true
  validates :from_email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
