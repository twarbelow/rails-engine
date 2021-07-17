class InvoiceItem < ApplicationRecord
  validates_presence_of :item_id
  validates_presence_of :invoice_id
  validates_presence_of :quantity
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :item
  belongs_to :invoice
end
