class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  # has_many :transactions, through: :invoices

  def self.paginated_merchants(page, per_page)
    if page.zero?
      Merchant.limit(per_page)
    else
      Merchant.limit(per_page)
              .offset((page - 1) * per_page)
    end
  end

  def self.revenue_total(merchant)
    merchant.invoices
            .joins(:transactions, :invoice_items)
            .where('transactions.result = ? AND invoices.status = ?', 'success', 'shipped')
            .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
