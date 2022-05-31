class PurchasesController < ApplicationController
  before_action :set_item
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_customer = PurchaseCustomer.new
  end

  def create
    @purchase_customer = PurchaseCustomer.new(purchase_params)
    if @purchase_customer.valid?
      pay_item
      @purchase_customer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_customer).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number)
          .merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if (user_signed_in? && current_user.id == @item.user_id) || @item.purchase.present?
      redirect_to root_path
    elsif user_signed_in? == false
      redirect_to new_user_session_path
    end
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
