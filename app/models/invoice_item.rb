class InvoiceItem < ApplicationRecord
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :item
  belongs_to :invoice
end
