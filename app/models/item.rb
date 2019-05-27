class Item < ApplicationRecord
  belongs_to :user
  validates :manufacturer, format: { with: /\A[a-zA-Z]+\z/,
    message: "no special characters allowed" }
  validates :manufacturer, length: { in: 2..20 }
  validates :price, numericality: { less_than: 100000 }
  validates :serial_number, uniqueness: true
end
