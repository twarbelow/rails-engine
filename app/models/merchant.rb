class Merchant < ApplicationRecord
  validates_presence_of :name

  # has_many :invoices
  # has_many :items
  # has_many :transactions, through: :invoices
end
