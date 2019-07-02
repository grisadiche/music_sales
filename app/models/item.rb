class Item < ApplicationRecord
  belongs_to :user

  validates_associated :user

  validates :manufacturer, :model, :price, :image, presence: true
  validates :manufacturer, :model, :color, :serial_number, format:
    { with: /\A[a-zA-Z0-9 _.-]+\z/, message: "no special characters allowed" }
  validates :manufacturer, :model, length: { in: 1..20 }

  validates :price, numericality: { less_than: 100_000 }

  validates :weight, numericality: { less_than: 10_000 }

  validates :description, length: { in: 1..160 }

  self.per_page = 3

  has_one_attached :image

  validate :image_format

  attr_accessor :stripe_token

  private

  def image_format
    errors.add(:image, "no file added") unless image.attached?
  end
end
