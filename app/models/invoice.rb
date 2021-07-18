class Invoice < ApplicationRecord
  validates_presence_of :merchant_id
  validates_presence_of :status

  belongs_to :merchant
  # belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions

end
