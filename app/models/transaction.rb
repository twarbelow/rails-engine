class Transaction < ApplicationRecord
  validates :invoice_id, presence: true
  # validates_presence_of :credit_card_number
  # validates_presence_of :credit_card_expiration
  validates :result, presence: true

  belongs_to :invoice
end
