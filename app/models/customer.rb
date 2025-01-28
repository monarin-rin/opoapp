class Customer < ApplicationRecord
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, allow_blank: true
end
