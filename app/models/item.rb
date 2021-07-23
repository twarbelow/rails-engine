class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # this must come before has_many invoice_items https://stackoverflow.com/a/31344318
  before_destroy :remove_empty_invoices

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.paginated_items(page, per_page)
    if page.zero?
      Item.limit(per_page)
    else
      Item.limit(per_page).offset((page - 1) * per_page)
    end
  end

  def self.get_by_params(name = nil, min = nil, max = nil)
    if name
      Item.where('name ILIKE ? OR description ILIKE ?', "%#{name}%", "%#{name}%").order(:name).first
    elsif min && !max
      Item.where('unit_price >= ?', min).order(:name).first
    elsif max
      Item.where('unit_price <= ?', max).order(:name).first
    else
      Item.where(unit_price: min..max).order(:name).first
    end
  end

  private

  def remove_empty_invoices
    invoices.each do |invoice|
      invoice.destroy if invoice.items.count == 1
    end
  end
end
