class PurchaseCustomer
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :block, :building, :phone_number, :user_id, :item_id, :purchase_id, :token

  with_options presence: true do
    validates :postcode, :prefecture_id, :city, :block, :phone_number, :user_id, :item_id, :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  POSTCODE_RULE = /\A\d{3}-\d{4}\z/.freeze
  validates_format_of :postcode, with: POSTCODE_RULE, message: 'is invalid. Enter it as follows (e.g. 123-4567)'
  PHONE_NUMBER_RULE = /\A\d{10,11}\z/.freeze
  validates_format_of :phone_number, with: PHONE_NUMBER_RULE, message: 'is too short'
  validates :phone_number, numericality: { message: 'is invalid. Input only number' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Customer.create(postcode: postcode, prefecture_id: prefecture_id, city: city,
                    block: block, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
