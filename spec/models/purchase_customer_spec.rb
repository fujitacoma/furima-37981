require 'rails_helper'

RSpec.describe PurchaseCustomer, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_customer = FactoryBot.build(:purchase_customer, user_id: user.id, item_id: item.id)
    sleep 0.1 
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '必要な情報が適切に入力されている場合購入できる' do
        expect(@purchase_customer).to be_valid
      end
    end

    context'商品購入できない場合' do
      it 'postcodeが空では購入できない' do
        @purchase_customer.postcode = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Postcode can't be blank"
      end
      it 'postcodeにハイフンがない場合購入できない' do
        @purchase_customer.postcode = '1234567'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Purchase can't be blank"
      end
        it 'postcodeが「3桁ハイフン4桁」でない場合購入できない' do
        @purchase_customer.postcode = '123-4567'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Purchase can't be blank"
      end
      it 'postcodeに全角が入力されていると登録できない' do
        @purchase_customer.postcode = 'テストーテスト'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Purchase can't be blank"
      end
      it 'postcodeが半角英字では登録できない' do
        @purchase_customer.postcode = 'test-test'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Purchase can't be blank"
      end
      it 'postcodeが半角カタカナでは登録できない' do
        @purchase_customer.postcode = 'ﾃｽﾄ-ﾃｽﾄ'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Purchase can't be blank"
      end
      it 'prefecture_idが1(---)では登録できない' do
        @purchase_customer.prefecture_id = 1
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Prefecture must be other than 1"
      end
      it 'cityが空では購入できない' do
        @purchase_customer.city = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "City can't be blank"
      end
      it 'blockが空では登録できない' do
        @purchase_customer.block = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Block can't be blank"
      end
      it 'phone_numberが空では購入できない' do
        @purchase_customer.phone_number = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone-numberが10桁以下の場合は購入できない' do
        @purchase_customer.phone_number = '090123456' 
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Phone number must be less than or equal to 11"
      end
      it 'phone-numberが11桁以上の場合は購入できない' do
        @purchase_customer.phone_number = '090-1234-5678'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include "Phone number is invalid. Input only number"
      end
      it 'ユーザー情報が紐づいていないと登録できない' do
        @purchase_customer.user_id = nil
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include 'User must exist'
      end
      it '商品情報が紐づいていないと登録できない' do
        @purchase_customer.item_id = nil
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include 'Item must exist'
      end
    end
  end
end
