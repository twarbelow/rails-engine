require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { validates_presence_of(:name, :description, :unit_price, :merchant_id) }
  end

  describe 'relationships' do
    it { belongs_to(:merchant) }
    # it { has_many(:invoice_itmes) }
    # it { has_many(:invoices).through(:invoice_items) }
  end
end
