class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :sending_date
  belongs_to :user

  # has_one :purchase
  has_one_attached :image

  validates :image, :item_name, :content, :price, presence: true
  validates :category_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates :status_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :sending_date_id,    numericality: { other_than: 1, message: "can't be blank" }
  PASSWORD_REGEX = /\A[0-9]+\z/.freeze
  validates_format_of :price, with: PASSWORD_REGEX, message: 'is invalid. Input half-width characters'
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'is out of setting range' }
end
