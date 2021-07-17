class Invoice < ApplicationRecord
  validates_presence_of :customer_id
  validates_presence_of :merchant_id
  validates_presence_of :status

  belongs_to :merchant
  # belongs_to :customer
end
