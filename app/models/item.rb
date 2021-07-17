require 'rails_helper'

class Item < ApplicationRecord
  validates_presence_of(:name, :description, :unit_price, :merchant_id)
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
