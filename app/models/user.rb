class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'

  validates :nickname,           presence: true

  with_options presence: true, format: { with: /\A[ぁ-ん一ァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
    validates :first_name, presence: true
    validates :last_name, presence: true
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :first_name_kana, presence: true
    validates :last_name_kana, presence: true
  end

  validates :birthday, presence: true

  has_many :items
  # has_many :purchases
end
